import 'package:data/data.dart';
import 'package:data/src/responses/transaction_response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

abstract class ISampleBusiness extends IBaseBusiness<SampleEntity> {
  Future<SampleResultResponse<AccountResponse>> createNewWallet(String account);
  Future<SampleResultResponse<AccountDataResponse>> getAccountData(
      String address);

  Future<SampleResultResponse> sendCoin(
      {String privateKey, String sender, int amount, String recipient});

  Future<SampleResultResponse<TransactionResponse>> fetchPendingTransaction();

  Future<void> mining();
}
