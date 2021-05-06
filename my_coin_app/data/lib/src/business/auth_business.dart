import 'package:flutter_sdk/flutter_sdk.dart';

import '../../data.dart';

class AuthBusiness implements IAuthBusiness {
  final IAuthService _service;
  final SharedPreferences _prefs;

  AuthBusiness(this._service, this._prefs);


  @override
  Future<bool> fetchUserInfo() async {
    final response = await _service.fetchUserInfo();
    if (response != null && response.success && response.item != null) {
      final userInfo = response.item;

      await _prefs.setUserInfo(userInfo);
    }

    return (response?.success ?? false);
  }
}
