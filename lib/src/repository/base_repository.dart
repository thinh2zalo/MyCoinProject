import '../database/base_database.dart';
import '../model/base_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import '../extensions/extension.dart';

class BaseRepository<TEntity extends BaseEntity> implements IBaseRepository<TEntity> {
  // final BaseDatabase _db;

  // BaseRepository(this._db);

  Uuid _uuid = Uuid();

  @override
  Future batchDelete(List<TEntity> collection) async {
    // if (_db == null || collection == null) return;
    // await _db.connection.batchDelete(collection);
  }

  @override
  Future batchInsertOrUpdate(List<TEntity> collection) async {
    // if (_db == null || collection == null) return;
    // await _db.connection.batchInsert(collection);
  }

  @override
  Future batchMarkDelete(List<TEntity> collection) async {
    // if (_db == null || collection == null) return;
    // await _db.connection.batchMarkDelete(collection);
  }

  @override
  Future batchUpdate(List<TEntity> collection) async {
    // if (_db == null || collection == null) return;
    // await _db.connection.batchUpdate(collection);
  }

  @override
  Future delete(TEntity entity) async {
    // if (_db == null || entity == null) return;
    // return await _db.connection.delete(entity);
  }

  // @override
  // Future insertOrUpdate(TEntity entity) async {
  //   if (_db == null || entity == null) return;
  //   entity.id ??= _uuid.v4();
  //   return await _db.connection.insertOrUpdate(entity);
  // }

  @override
  Future markDelete(TEntity entity) async {
    // todo: implement later
  }

  @override
  Future update(TEntity entity) async {
    // if (_db == null || entity == null) return;
    // return await _db.connection.update(entity);
  }

  @override
  Future exec(String query) async {
    // if (_db == null) return;
    // await _db.connection.exec(query);
  }

  @override
  Future<List<TEntity>> list({String where, String orderBy, int pageIndex, int limit, List<dynamic> args = const <dynamic>[]}) async {
    TEntity entity = GetIt.instance.get<TEntity>();
    var query = 'select * from ${entity.table}';

    if (where != null) {
      query += ' where $where';
    }

    if (orderBy != null) {
      query += ' order by $orderBy';
    }

    if (limit != null) {
      query += ' limit $limit';
      if (pageIndex != null) {
        var skip = (pageIndex - 1) * limit;
        query += ' offset $skip';
      }
    }
    return await _rawQuery(query, entity.fromJsonConvert, args);
  }

  Future<List<TEntity>> _rawQuery(
      String query,
      TEntity Function(
    Map<String, dynamic>,
  )
          fromJson,
      [final List<dynamic> args = const <dynamic>[]]) async {
    // var result = await _db.connection.list(query, args);
    // return result.map((json) => fromJson(json)).toList();
  }

  @override
  Future<TEntity> getById(String id) async {
    var result = await list(where: 'id = ?', orderBy: null, pageIndex: null, limit: 1, args: <String>[id]);
    return result?.firstOrDefault();
  }

  @override
  Future insertOrUpdate(TEntity entity) {
    // // TODO: implement insertOrUpdate
    // throw UnimplementedError();
  }
}

abstract class IBaseRepository<TEntity extends BaseEntity> {
  Future insertOrUpdate(TEntity entity);

  Future update(TEntity entity);

  Future delete(TEntity entity);

  Future markDelete(TEntity entity);

  Future batchInsertOrUpdate(List<TEntity> collection);

  Future batchUpdate(List<TEntity> collection);

  Future batchDelete(List<TEntity> collection);

  Future batchMarkDelete(List<TEntity> collection);

  Future<List<TEntity>> list({String where, String orderBy, int pageIndex, int limit, final List<dynamic> args = const <dynamic>[]});

  Future exec(String query);

  Future<TEntity> getById(String id);
}