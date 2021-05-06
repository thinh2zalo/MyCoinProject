import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:data/data.dart';


class EntityDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<SampleEntity>(() => SampleEntity());
  }
}
