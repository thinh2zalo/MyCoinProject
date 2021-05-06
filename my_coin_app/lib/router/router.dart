import 'package:flutter/material.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

class Routes {
  static String get defaultRoute => '/';
  static String get splash => '/splash';
  static String get sample => '/sample';
  static String get sampleDetail => '/sampleDetail';
  static String get home => '/homePage';

  static getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Page not found')),
      );
    }
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
