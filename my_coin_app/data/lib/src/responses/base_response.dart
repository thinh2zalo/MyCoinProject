import 'package:flutter_sdk/flutter_sdk.dart';
import '../helpers/helper.dart';

class ResultResponse<TResponse extends BaseResponse> extends BaseResponse {
  TResponse item;
  ErrorResponse error;

  ResultResponse(this.item) : super();

  @override
  bool get success =>
      statusCode == 200 || statusCode == 201 || statusCode == 204;

  ResultResponse.fromJson(Response response) {
    if (response != null) this.statusCode = response.statusCode;

    final map = JsonHelper.getMap(response.data);
    if (success) {
      if (map != null) {
        final result = GetIt.I.get<TResponse>();
        this.item = result.fromJson<TResponse>(map);
      }
    } else {
      this.error = ErrorResponse.fromJson(map);
    }
  }
}

class ListResultResponse<TResponse extends BaseResponse> extends BaseResponse {
  List<TResponse> items;
  ErrorResponse error;

  ListResultResponse(this.items) : super();

  @override
  bool get success =>
      statusCode == 200 || statusCode == 201 || statusCode == 204;

  ListResultResponse.fromJson(Response response) {
    if (response != null) this.statusCode = response.statusCode;

    if (success) {
      final list = JsonHelper.getMapList(response.data);
      final result = GetIt.I.get<TResponse>();

      items = list.map((map) => result.fromJson<TResponse>(map)).toList();
    } else {
      final map = JsonHelper.getMap(response.data);
      this.error = ErrorResponse.fromJson(map);
    }
  }
}

