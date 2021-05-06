import 'package:flutter_sdk/flutter_sdk.dart';

class NoResponse extends BaseResponse {

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return null;
  }

}