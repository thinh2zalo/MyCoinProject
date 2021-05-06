import 'package:example/pages/phone/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../router/router.dart';
import '../pages/pages.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SamplePage(injector()),
        instanceName: Routes.sample);
    injector.registerFactory<Widget>(() => HomePage(injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => SampleDetailPage(injector()),
        instanceName: Routes.sampleDetail);
  }
}
