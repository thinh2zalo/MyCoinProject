import 'package:flutter_sdk/flutter_sdk.dart';

class AuthResponse extends BaseResponse {
  final String accessToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final String refreshToken;
  final String tokenType;
  final String idToken;
  final int notBeforePolicy;
  final String sessionState;
  final String scope;
  final String errorCode;
  final String message;

  AuthResponse({
    this.expiresIn,
    this.refreshToken,
    this.accessToken,
    this.message,
    this.errorCode,
    this.idToken,
    this.notBeforePolicy,
    this.refreshExpiresIn,
    this.scope,
    this.sessionState,
    this.tokenType,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
      refreshExpiresIn: json['refresh_expires_in'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      idToken: json['id_token'],
      notBeforePolicy: json['not-before-policy'],
      sessionState: json['session_state'],
      scope: json['scope'],
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return AuthResponse.fromJson(json) as T;
  }
}