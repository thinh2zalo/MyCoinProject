import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'sqlite_connection.dart';

class BaseDatabase {
  ISQLiteConnection connection;
  final String dbPath;
  final String scriptPath;
  BaseDatabase(this.dbPath, this.scriptPath);

  Future open() async {
    if (connection == null) {
      connection = SQLiteConnection(dbPath);
      var config = await _getConfig();
      await connection.open(config);
    }
  }

  Future dispose() async {
    if (connection != null) {
      connection.dispose();
    }
  }

  Future<MigrationConfig> _getConfig() async {
    final jsonString = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = json.decode(jsonString);

    var initPath = path.join(scriptPath, 'init');
    var migrationPath = path.join(scriptPath, 'migration');
    var initScripts = await _getScriptPath(initPath, manifest);
    var migrationScripts = await _getScriptPath(migrationPath, manifest);
    return MigrationConfig(
        initializationScript: initScripts, migrationScripts: migrationScripts);
  }

  Future<List<String>> _getScriptPath(String folderPath, Map<String, dynamic> manifest) async {
    var files = manifest.keys.where((element) => element.contains(folderPath)).toList();
    if (files.length > 0) {
      return files;
    }
    return [];
  }

  Future<void> reset() async {
    if (connection == null) return;
    await dispose();
    await File(dbPath).delete(recursive: true);
    connection = null;
    await open();
  }
}
