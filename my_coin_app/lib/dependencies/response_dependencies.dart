import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:data/data.dart';

class ResponseDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<SampleResponse>(() => SampleResponse());
    injector.registerFactory<AccountResponse>(() => AccountResponse());
  }
}
