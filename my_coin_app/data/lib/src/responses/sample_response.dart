import 'dart:convert';

import '../entities/entities.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

Map<String, dynamic> _getMap(dynamic data) {
  if (data is Map) return data as Map<String, dynamic>;
  return json.decode(data.toString()) as Map<String, dynamic>;
}

class SampleResultResponse<TResponse extends BaseResponse> extends BaseResponse {
  List<TResponse> items;

  SampleResultResponse({this.items});

  SampleResultResponse.fromJson(Map<String, dynamic> json) {
    final response = GetIt.I.get<TResponse>();
    items = (json['items'] as List)?.map((item) => response.fromJson(_getMap(item)) as TResponse)?.toList() ?? [];
  }
}

class SampleResponse extends BaseResponse {
  final String id;
  final String productName;
  final String image;
  final String description;
  final String regularPrice;
  final String salePrice;

  SampleResponse({
    this.id,
    this.productName,
    this.image,
    this.description,
    this.regularPrice,
    this.salePrice,
  });

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return SampleResponse.fromJson(json) as T;
  }

  factory SampleResponse.fromJson(Map<String, dynamic> json) {
    return SampleResponse(
      id: json['id'],
      productName: json['productName'],
      image: json['image'] is bool ? '' : json['image'],
      description: json['description'],
      regularPrice: json['regularPrice'],
      salePrice: json['salePrice'],
    );
  }

  SampleEntity toEntity() {
    return SampleEntity(
      id: id,
      productName: productName,
      image: image,
      description: description,
      regularPrice: regularPrice,
      salePrice: salePrice,
    );
  }
}