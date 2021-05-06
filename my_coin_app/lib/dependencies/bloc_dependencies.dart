import 'package:flutter_sdk/flutter_sdk.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<SampleBloc>(() => SampleBloc(injector()));
    injector.registerFactory<SampleDetailBloc>(() => SampleDetailBloc(injector()));
  }
}
