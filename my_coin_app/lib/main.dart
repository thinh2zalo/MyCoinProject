import 'package:example/utils/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'dependencies/dependencies.dart';
import 'enums.dart';
import 'utils/utils.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/licenses/OFL_SFPro.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.instance.loadConfig(env: Environment.dev);
  await AppDependencies.setup();

  runApp(App());
}
