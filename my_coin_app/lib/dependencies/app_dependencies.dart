import 'package:flutter_sdk/flutter_sdk.dart';

import 'dependencies.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.I;

  static Future<void> setup() async {
    _injector.registerLazySingleton<SharedPreferences>(() => SharedPreferences());

    await ResponseDependencies.setup(_injector);
    await RestDependencies.setup(_injector);
    await DatabaseDependencies.setup(_injector);
    await EntityDependencies.setup(_injector);
    await ServiceDependencies.setup(_injector);
    await RepositoryDependencies.setup(_injector);
    await BusinessDependencies.setup(_injector);
    await BlocDependencies.setup(_injector);
    await PageDependencies.setup(_injector);
  }
}
