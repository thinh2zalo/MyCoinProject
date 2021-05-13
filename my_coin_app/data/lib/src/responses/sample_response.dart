import 'dart:convert';

import 'package:data/data.dart';
import 'package:data/src/models/account_model.dart';

import 'package:flutter_sdk/flutter_sdk.dart';

Map<String, dynamic> _getMap(dynamic data) {
  if (data is Map) return data as Map<String, dynamic>;
  return json.decode(data.toString()) as Map<String, dynamic>;
}

class SampleResultResponse<TResponse extends BaseResponse>
    extends BaseResponse {
  List<TResponse> items;

  SampleResultResponse({this.items});

  SampleResultResponse.fromJson(Map<String, dynamic> json) {
    final response = GetIt.I.get<TResponse>();
    items = (json['items'] as List)
            ?.map((item) => response.fromJson(_getMap(item)) as TResponse)
            ?.toList() ??
        [];
  }
}

// class SendCoinResponse extends BaseResponse {
//   SendCoinResponse.fromJson(Map<String, dynamic> json) {
//     final response = json['note'];
//   }
// }

class AccountResponse extends BaseResponse {
  int id;
  String privateKey;
  String publicKey;
  String account;
  int amount;

  AccountResponse(
      {this.id, this.privateKey, this.publicKey, this.account, this.amount});

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return AccountResponse.fromJson(json) as T;
  }

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      id: json['userId'],
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
      account: json['account'],
      amount: json['amount'],
    );
  }

  AccountModel toModel() {
    return AccountModel(
      id: this.id,
      privateKey: this.privateKey,
      publicKey: this.publicKey,
      accountName: this.account,
      amount: this.amount,
    );
  }
}

class AccountDataResponse extends BaseResponse {
  int id;

  int balance;
  List<TransactionResponse> listTransaction;

  AccountDataResponse({this.balance, this.listTransaction});

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return AccountDataResponse.fromJson(json) as T;
  }

  factory AccountDataResponse.fromJson(Map<String, dynamic> json) {
    final response = GetIt.I.get<TransactionResponse>();

    final items = (json['addressTransactions'] as List)
            ?.map((item) =>
                response.fromJson(_getMap(item)) as TransactionResponse)
            ?.toList() ??
        [];
    return AccountDataResponse(
        balance: json['addressBalance'], listTransaction: items);
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
}
