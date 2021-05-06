import 'dart:convert';
import 'package:flutter_sdk/flutter_sdk.dart';
import '../../data.dart';

class AuthService implements IAuthService {
  final IRestUtility _authRest;
  final IRestUtility _userRest;
  final IRestUtility _userTokenRest;

  AuthService()
      : _authRest = GetIt.I.get<IRestUtility>(instanceName: 'authentication'),
        _userRest = GetIt.I.get<IRestUtility>(instanceName: 'user'),
        _userTokenRest = GetIt.I.get<IRestUtility>(instanceName: 'userToken');

  @override
  Future<ResultResponse<AuthResponse>> signInWithPin(Map<String, dynamic> data) async {
    final response = await _authRest.request('/token', Method.POST, data: data);
    if (response == null) return null;
    return ResultResponse<AuthResponse>.fromJson(response);
  }

  @override
  Future<ResultResponse<AuthResponse>> resetPin(Map<String, dynamic> params) async {
    final response = await _userTokenRest.request('/api/users/password', Method.PUT, data: params);

    if (response == null) return null;
    return ResultResponse<AuthResponse>.fromJson(response);
  }

  @override
  Future<String> verifyPhoneNumber({String phoneNumber, String deviceId}) async {
    final response = await _userRest.request(
      '/api/v1/authen/validateUser/$phoneNumber/$deviceId',
      Method.GET,
    );
    try {
      final result = jsonDecode(response.data);
      return result;
    } catch (e) {
      Log.e(e.toString(), tag: '$runtimeType');
    }
    return null;
  }

  @override
  Future<bool> verifyFcmToken({String fcmToken}) async {
    final response = await _userTokenRest.request(
      '/api/v1/authen/validateUser/$fcmToken',
      Method.GET,
    );
    return response?.data == true;
  }

  @override
  Future<ResultResponse<UserInfo>> fetchUserInfo() async {
    final response = await _userTokenRest.request('/api/account', Method.GET);
    if (response == null) return null;
    return ResultResponse<UserInfo>.fromJson(response);
  }
}
