import '../model/base_entity.dart';
import '../repository/base_repository.dart';

class BaseBusiness<TEntity extends BaseEntity> implements IBaseBusiness<TEntity> {
  final IBaseRepository _repository;

  BaseBusiness([IBaseRepository repository]) : _repository = repository;

  @override
  Future batchDelete(List<TEntity> collection) async {
    if (_repository == null) return;
    await _repository.batchDelete(collection);
  }

  @override
  Future batchInsertOrUpdate(List<TEntity> collection) async {
    if (_repository == null) return;
    await _repository.batchInsertOrUpdate(collection);
  }

  @override
  Future batchMarkDelete(List<TEntity> collection) async {
    if (_repository == null) return;
    await _repository.batchMarkDelete(collection);
  }

  @override
  Future batchUpdate(List<TEntity> collection) async {
    if (_repository == null) return;
    await _repository.batchUpdate(collection);
  }

  @override
  Future delete(TEntity entity) async {
    if (_repository == null) return;
    return await _repository.delete(entity);
  }

  @override
  Future exec(String query) async {
    if (_repository == null) return;
    return await _repository.exec(query);
  }

  @override
  Future<TEntity> getById(String id) async {
    if (_repository == null) return null;
    return await _repository.getById(id);
  }

  @override
  Future insertOrUpdate(TEntity entity) async {
    if (_repository == null) return;
    return await _repository.insertOrUpdate(entity);
  }

  @override
  Future<List<TEntity>> list({String where, String orderBy, int pageIndex, int limit, List args = const <dynamic>[]}) async {
    if (_repository == null) return [];
    return await _repository.list(where: where, orderBy: orderBy, pageIndex: pageIndex, limit: limit, args: args);
  }

  @override
  Future markDelete(TEntity entity) async {
    if (_repository == null) return;
    return await _repository.markDelete(entity);
  }

  @override
  Future update(TEntity entity) async {
    if (_repository == null) return;
    return await _repository.update(entity);
  }
}

abstract class IBaseBusiness<TEntity extends BaseEntity> {
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