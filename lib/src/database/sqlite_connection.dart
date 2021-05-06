import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../model/base_entity.dart';
import '../utility/log.dart';

abstract class ISQLiteConnection {
  Future open(MigrationConfig config);

  Future dispose();

  Future insertOrUpdate(BaseEntity entity);

  Future delete(BaseEntity entity);

  Future markDelete(BaseEntity entity);

  Future update(BaseEntity entity);

  Future exec(String query);

  Future batchInsert(List<BaseEntity> collection);

  Future batchUpdate(List<BaseEntity> collection);

  Future batchDelete(List<BaseEntity> collection);

  Future batchMarkDelete(List<BaseEntity> collection);

  Future<List<Map<String, dynamic>>> list(String query, [final List<dynamic> args = const <dynamic>[]]) async {
    return null;
  }
}

class SQLiteConnection implements ISQLiteConnection {
  Database _db;
  Batch _batch;
  final Uuid _uuid = Uuid();

  final String path;

  SQLiteConnection(this.path);

  @override
  Future open(MigrationConfig config) async {
    final MigrationFactory factory = MigrationFactory(config);
    _db = await openDatabase(
      path,
      onCreate: factory.executeInitialization,
      onUpgrade: factory.executeMigration,
      version: config.migrationScripts.length + 1,
    );
    _batch = _db.batch();
  }

  @override
  Future dispose() async {
    if (_db != null) {
      _db.close();
    }
  }

  @override
  Future insertOrUpdate(BaseEntity entity) async {
    entity.id ??= _uuid.v4();
    _batch.insert(
      entity.table,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _batch.commit(noResult: true, continueOnError: false);
  }

  @override
  Future markDelete(BaseEntity entity) async {
    //todo
    _batch.update(
      entity.table,
      entity.toJson(),
      where: 'id = ?',
      whereArgs: <String>[entity.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _batch.commit(noResult: true, continueOnError: false);
  }

  @override
  Future update(BaseEntity entity) async {
    _batch.update(
      entity.table,
      entity.toJson(),
      where: 'id = ?',
      whereArgs: <String>[entity.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _batch.commit(noResult: true, continueOnError: false);
  }

  @override
  Future delete(BaseEntity entity) async {
    _batch.delete(
      entity.table,
      where: 'id = ?',
      whereArgs: <String>[entity.id],
    );
    await _batch.commit(noResult: true, continueOnError: false);
  }

  @override
  Future exec(String query) async {
    await _db.execute(query);
  }

  @override
  Future<List<Map<String, dynamic>>> list(String query, [List args = const <dynamic>[]]) async {
    return await _db.rawQuery(query, args);
  }

  @override
  Future batchDelete(List<BaseEntity> collection) async {
    try {
      for (var entity in collection) {
        _batch.delete(entity.table, where: 'id = ?', whereArgs: <String>[entity.id]);
      }
      await _batch.commit(noResult: true, continueOnError: false);
    } catch (e) {
      Log.e(e.toString(), tag: 'DATABASE');
    }
  }

  @override
  Future batchInsert(List<BaseEntity> collection) async {
    try {
      for (var entity in collection) {
        entity.id ??= _uuid.v4();
        _batch.insert(entity.table, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await _batch.commit(noResult: true, continueOnError: false);
    } catch (e) {
      Log.e(e.toString(), tag: 'DATABASE');
    }
  }

  @override
  Future batchMarkDelete(List<BaseEntity> collection) async {
    //todo
    try {
      for (var entity in collection) {
        // entity.isDeleted = true;
        _batch.update(
          entity.table,
          entity.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'id = ?',
          whereArgs: <String>[entity.id],
        );
      }
      await _batch.commit(noResult: true, continueOnError: false);
    } catch (e) {
      Log.e(e.toString(), tag: 'DATABASE');
    }
  }

  @override
  Future batchUpdate(List<BaseEntity> collection) async {
    try {
      for (var entity in collection) {
        _batch.update(
          entity.table,
          entity.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: 'id = ?',
          whereArgs: <String>[entity.id],
        );
      }
      await _batch.commit(noResult: true, continueOnError: false);
    } catch (e) {
      Log.e(e.toString(), tag: 'DATABASE');
    }
  }
}

class MigrationConfig {
  final List<String> initializationScript;
  final List<String> migrationScripts;

  MigrationConfig({this.initializationScript, this.migrationScripts})
      : assert(initializationScript != null, 'The initializationScript cannot be null.'),
        assert(migrationScripts != null, 'The migrationScripts cannot be null.');
}

class MigrationFactory {
  final MigrationConfig config;

  MigrationFactory(this.config);

  Future<void> executeInitialization(Database db, int version) async {
    config.initializationScript.forEach((script) async => await _runScript(db, script));
    config.migrationScripts.forEach((script) async => await _runScript(db, script));
  }

  Future<void> executeMigration(Database db, int oldVersion, int newVersion) async {
    assert(oldVersion < newVersion, 'The newVersion($newVersion) should always be greater than the oldVersion($oldVersion).');
    assert(config.migrationScripts.length == newVersion - 1, 'New version ($newVersion) requires exact ${newVersion - config.migrationScripts.length} migrations.');

    for (var i = oldVersion - 1; i < newVersion - 1; i++) {
      await _runScript(db, config.migrationScripts[i]);
    }
  }

  Future _runScript(Database db, String path) async {
    var text = await rootBundle.loadString(path);
    var scriptLines = text.trim().split(';');
    if (scriptLines.isNotEmpty) {
      for (var i = 0; i < scriptLines.length; i++) {
        if (kDebugMode) {
          print(scriptLines[i]);
        }
        if (scriptLines[i] != null && scriptLines[i].trim().isNotEmpty) {
          await db.execute(scriptLines[i]);
        }
      }
    }
  }
}
