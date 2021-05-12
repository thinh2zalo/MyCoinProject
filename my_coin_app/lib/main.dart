import 'package:example/utils/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'app.dart';
import 'dependencies/dependencies.dart';
import 'enums.dart';
import 'utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/licenses/OFL_SFPro.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  print('socket');
  IO.Socket socket = IO.io(
      'http://localhost:3001',
      OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
  await AppConfig.instance.loadConfig(env: Environment.dev);
  await AppDependencies.setup();

  runApp(App());
}
