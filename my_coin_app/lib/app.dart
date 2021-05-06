import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import 'enums.dart';
import 'blocs/blocs.dart';
import 'resources/resources.dart';
import 'router/router.dart';
import 'theme/theme.dart';

final navigationKey = GlobalKey<NavigatorState>();
bool isLogout = false;

class App extends StatefulWidget {
  App({Key key}) : super(key: key) {
    Log.init();
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: appBloc..init()),
      ],
      child: Consumer<AppBloc>(
        builder: (_, bloc) => StreamBuilder<AppState>(
          stream: bloc.stateStream,
          builder: (context, snapshot) => _buildApp(snapshot?.data),
        ),
      ),
    );
  }

  Widget _buildApp(AppState state) {
    return MaterialApp(
      navigatorKey: navigationKey,
      title: UI.app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeBuilder.build(context, AppTheme.light.value,
          fontFamily: state?.fontFamily),
      darkTheme: ThemeBuilder.build(context, AppTheme.dark.value,
          fontFamily: state?.fontFamily),
      themeMode: ThemeBuilder.themeMode(state?.appTheme),
      initialRoute: Routes.home,
      onGenerateRoute: (settings) => Routes.getRoute(settings),
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: state?.locale,
      localeResolutionCallback: AppLocalizations.delegate.resolution(
        fallback: AppLocalizations.delegate.supportedLocales.first,
      ),
    );
  }
}
