import 'package:data/src/responses/transaction_response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../responses/response.dart';

abstract class ISampleService {
  Future<SampleResultResponse<SampleResponse>> fetchProduct();
  Future<SampleResultResponse<AccountResponse>> createNewWallet(String account);
  Future<SampleResultResponse<AccountDataResponse>> getAccountAdress(
      String account);
  Future<SampleResultResponse<BaseResponse>> sendCoin(
      {String privateKey, String sender, int amount, String recipient});
  Future<SampleResultResponse<TransactionResponse>> fetchPendingTransaction();

  Future<void> mine();
}
