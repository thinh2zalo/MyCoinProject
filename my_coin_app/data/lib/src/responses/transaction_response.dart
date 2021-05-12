import 'package:flutter_sdk/flutter_sdk.dart';

class TransactionResponse extends BaseResponse {
  final String transactionId;
  final String sender;
  final String recipient;
  final int amount;

  TransactionResponse(
      {this.transactionId, this.sender, this.recipient, this.amount});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactionId: json['transactionId'],
      sender: json['sender'],
      recipient: json['recipient'],
      amount: json['amount'],
    );
  }

  @override
  T fromJson<T extends BaseResponse>(Map<String, dynamic> json) {
    return TransactionResponse.fromJson(json) as T;
  }
}
