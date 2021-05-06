import 'package:data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_sdk/flutter_sdk.dart';

class DatabaseDependencies {
  static Future setup(GetIt injector) async {
    final documentPath = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentPath.path, 'data');
    final scriptPath = 'assets/database';
    if (kDebugMode) {
      print(dbPath);
    }

    injector.registerSingleton<CoreDatabase>(
        CoreDatabase(path.join(dbPath, 'core_database.db'), scriptPath));
  }
}
