import 'package:data/src/responses/transaction_response.dart';

import '../responses/response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../data.dart';
import 'interfaces/sample_business.dart';

class SampleEntity extends BaseEntity {
  @override
  // TODO: implement table
  String get table => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class SampleBusiness extends BaseBusiness<SampleEntity>
    implements ISampleBusiness {
  final ISampleService _service;
  final db = DatabaseHelper();
  SampleBusiness(this._service);

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

  @override
  Future<SampleResultResponse<BaseResponse>> sendCoin(
      {String privateKey, String sender, int amount, String recipient}) async {
    final response = await _service.sendCoin(
        privateKey: privateKey,
        sender: sender,
        amount: amount,
        recipient: recipient);
    return response;
  }

  @override
  Future<SampleResultResponse<TransactionResponse>>
      fetchPendingTransaction() async {
    final response = _service.fetchPendingTransaction();
    return response;
  }

  @override
  Future<void> mining() async {
    _service.mine();
  }
}
