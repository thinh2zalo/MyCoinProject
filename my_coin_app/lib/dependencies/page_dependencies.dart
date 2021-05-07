import 'package:example/pages/phone/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../router/router.dart';
import '../pages/pages.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => HomePage(),
        instanceName: Routes.home);
  }
}
