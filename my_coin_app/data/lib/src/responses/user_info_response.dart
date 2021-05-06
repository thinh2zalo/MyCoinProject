
import 'package:flutter_sdk/flutter_sdk.dart';

UserInfo userInfoFromJson(Map<String, dynamic> json) => UserInfo.fromJson(json);

Map<String, dynamic> userInfoToJson(UserInfo data) => data.toJson();

class UserInfo extends BaseResponse {
  UserInfo({
    this.phoneNumber,
  });

  String phoneNumber;

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) => UserInfo.fromJson(json) as T;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {

    "phoneNumber": phoneNumber,
  };
}