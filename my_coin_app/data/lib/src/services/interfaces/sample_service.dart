import 'package:flutter_sdk/flutter_sdk.dart';

import '../../responses/response.dart';

abstract class ISampleService {
  Future<SampleResultResponse<SampleResponse>> fetchProduct();
  Future<BaseResponse> createNewWallet();
}
