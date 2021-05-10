import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

abstract class ISampleBusiness extends IBaseBusiness<SampleEntity> {
  Future<BaseResponse> createNewWallet(String account);
}
