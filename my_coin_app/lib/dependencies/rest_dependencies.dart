import 'package:example/utils/app_config.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../utils/utils.dart';

class RestDependencies {
  static GetIt get _injector => GetIt.I;

  static Future setup(GetIt injector) async {
    _injector.registerLazySingleton<IRestUtility>(
        () => RestUtility('http://localhost:3001/'),
        instanceName: 'SAMPLE');

    _injector.registerLazySingleton<IRestUtility>(
      () => RestUtility(
        AppConfig.instance.apiEndpointAuth,
      ),
      instanceName: 'authentication',
    );
  }
}
