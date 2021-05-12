import '../responses/response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../data.dart';
import 'interfaces/sample_business.dart';

class SampleBusiness extends BaseBusiness<SampleEntity>
    implements ISampleBusiness {
  final ISampleService _service;
  final db = DatabaseHelper();
  SampleBusiness(this._service);

  @override
  Future<SampleResultResponse<SampleResponse>> fetchProduct() async {
    final response = await _service.fetchProduct();
    if (response.success) {
      final entities = response.items?.map((item) => item.toEntity())?.toList();
      batchInsertOrUpdate(entities);
    }
    return response;
  }

  @override
  Future<SampleResultResponse<AccountResponse>> createNewWallet(
      String account) async {
    final response = await _service.createNewWallet(account);
    if (response.success) {
      final entities = response.items?.map((item) => item.toModel())?.toList();
      for (AccountModel a in entities) {
        db.saveUser(a);
      }
    }
    return response;
  }

  @override
  Future<SampleResultResponse<AccountDataResponse>> getAccountData(
      String address) async {
    final response = await _service.getAccountAdress(address);
    if (response.success) {}
    return response;
  }
}
