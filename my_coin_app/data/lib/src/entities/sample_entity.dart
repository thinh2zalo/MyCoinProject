import 'package:flutter_sdk/flutter_sdk.dart';

import '../../data.dart';
import '../models/model.dart';

class SampleEntity extends BaseEntity {
  final String id;
  final String productName;
  final String image;
  final String description;
  final String regularPrice;
  final String salePrice;

  SampleEntity({
    this.id,
    this.productName,
    this.image,
    this.description,
    this.regularPrice,
    this.salePrice,
  });

  @override
  String get table => 'SampleEntity';

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'image': image,
      'description': description,
      'regularPrice': regularPrice,
      'salePrice': salePrice,
    };
  }

  @override
  T fromJsonConvert<T extends BaseEntity>(Map<String, dynamic> json) {
    return SampleEntity(
      id: json['id'],
      productName: json['productName'],
      image: json['image'],
      description: json['description'],
      regularPrice: json['regularPrice'],
      salePrice: json['salePrice'],
    ) as T;
  }

  SampleModel toModel() {
    return SampleModel(
      id: id,
      productName: productName,
      image: image,
      description: description,
      regularPrice: regularPrice,
      salePrice: salePrice,
    );
  }
}
