import 'dart:convert';
import 'package:flutter_sdk/flutter_sdk.dart';
import '../../data.dart';

extension SharedPreferencesExtension on SharedPreferences {
  Future<String> get pinCode async =>
      await getValue(SharedPreferencesKey.pinCode, isSecure: true);

  Future<void> setPinCode(String pinCode) async =>
      await setSecureValue(SharedPreferencesKey.pinCode, pinCode);

  Future<String> get phoneNumber async =>
      await getValue(SharedPreferencesKey.phoneNumber, isSecure: true);

  Future<void> setPhoneNumber(String phoneNumber) async =>
      await setSecureValue(SharedPreferencesKey.phoneNumber, phoneNumber);

  Future<UserInfo> get userInfo async {
    final json = await getValue(SharedPreferencesKey.userInfo, isSecure: true);
    return json == null || json.toString().isEmpty
        ? null
        : userInfoFromJson(jsonDecode(json));
  }

  Future<void> setUserInfo(UserInfo userInfo) async {
    if (userInfo != null) {
      await setSecureValue(
          SharedPreferencesKey.userInfo, jsonEncode(userInfo.toJson()));
    }
  }
}
