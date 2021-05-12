import 'package:flutter_sdk/flutter_sdk.dart';

import '../../responses/response.dart';

abstract class ISampleService {
  Future<SampleResultResponse<SampleResponse>> fetchProduct();
  Future<SampleResultResponse<AccountResponse>> createNewWallet(String account);
  Future<SampleResultResponse<AccountDataResponse>> getAccountAdress(
      String account);
}
