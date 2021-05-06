import 'package:flutter_sdk/flutter_sdk.dart';

class CoreDatabase extends BaseDatabase {
  CoreDatabase(String dbPath, String scriptPath) : super(dbPath, scriptPath) {
    open();
  }
}