import 'dart:core';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'package:data/data.dart';
import '../../utils/utils.dart';

class SecurityInterceptor extends Interceptor {
  final String _instanceName;
  final SharedPreferences _prefs;

  SecurityInterceptor({String restInstanceName})
      : _instanceName = restInstanceName.isNotNullOrEmpty ? restInstanceName : 'authentication',
        _prefs = GetIt.I<SharedPreferences>();

  @override
  Future onRequest(RequestOptions options) async {
    final expiresInValue = await _prefs.expiresIn; // formatted to UTC Iso-8601
    final expiresInUtc = DateTimeConverter().fromJson(expiresInValue);
    String token = await _prefs.accessToken;

    if (expiresInUtc == null || expiresInUtc < DateTime.now().toUtc()) {
      final newToken = await _refreshToken();
      if (newToken.isNotNullOrEmpty) {
        token = newToken;
      }
    }

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options);
  }

  Future<String> _handleResponse(Response response) async {
    final now = DateTime.now().toUtc();
    if (response != null) {
      try {
        final resultResponse = ResultResponse<AuthResponse>.fromJson(response);
        if (resultResponse.success) {
          String accessToken = await _prefs.accessToken;
          String refreshToken = await _prefs.refreshToken;

          accessToken = resultResponse.item?.accessToken ?? accessToken;
          refreshToken = resultResponse.item?.refreshToken ?? refreshToken;

          await _prefs.setRefreshToken(refreshToken);
          await _prefs.setAccessToken(accessToken);
          await _prefs.setExpiresIn(_handleExpireTime(now, resultResponse?.item?.expiresIn ?? 0).toIso8601String());

          return accessToken;
        }
      } catch (e) {
        Log.e('$e', tag: '$runtimeType');
      }
    }

    return null;
  }

  DateTime _handleExpireTime(DateTime startTimeUtc, dynamic value) {
    final now = startTimeUtc ?? DateTime.now().toUtc();

    if (int.tryParse(value.toString()) != null) {
      return now.add(Duration(seconds: int.tryParse(value.toString())));
    }

    final DateTime parsedDate = DateTimeConverter().fromJson(value)?.toUtc();
    return parsedDate ?? now;
  }

  Future<String> _refreshToken() async {
    final rest = GetIt.I.get<IRestUtility>(instanceName: _instanceName);
    if (rest != null) {
      final String refreshToken = await _prefs.refreshToken;
      if (refreshToken.isNotNullOrEmpty) {
        final Map<String, dynamic> data = {
          "grant_type": "refresh_token",
          "scope": AppConfig.instance.scope,
          "client_id": AppConfig.instance.clientId,
          "refresh_token": refreshToken,
        };
        final response = await rest.request(
          '/token',
          Method.POST,
          data: data,
        );
        return _handleResponse(response);
      }
    }

    return null;
  }
}
