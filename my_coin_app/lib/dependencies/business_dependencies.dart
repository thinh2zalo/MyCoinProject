import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:data/data.dart';

class BusinessDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISampleBusiness>(() => SampleBusiness(injector(), injector()));
  }
}
