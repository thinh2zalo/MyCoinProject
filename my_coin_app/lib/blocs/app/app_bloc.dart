import 'dart:async';

import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../enums.dart';
import '../../theme/theme.dart';
import '../blocs.dart';
import 'app_state.dart';

class AppBloc extends BaseBloc<AppState> {
  SharedPreferences _prefs;

  AppBloc() {
    _prefs = GetIt.I.get<SharedPreferences>();
    emit(AppState(
      appTheme: AppTheme.light.value,
      locale: LocaleBuilder.getLocale(Language.vi.value),
      fontFamily: SupportedFont.SFPro.value,
    ));
  }

  Future<void> init() async {
    final theme = await _prefs.getValue(SharedPreferencesKey.theme);
    final language = await _prefs.getValue(SharedPreferencesKey.language);

    emit(AppState(
      state: state,
      locale: LocaleBuilder.getLocale(language ?? Language.vi.value),
      appTheme: theme ?? AppTheme.light.value,
    ));
  }

  Future<void> changeTheme(String theme) async {
    await _prefs.setValue(SharedPreferencesKey.theme, theme);
    emit(AppState(
      appTheme: theme,
      state: state,
    ));
  }

  Future<void> changeLanguage(String language) async {
    await _prefs.setValue(SharedPreferencesKey.language, language);
    emit(AppState(
      locale: LocaleBuilder.getLocale(language),
      state: state,
    ));
  }
}
