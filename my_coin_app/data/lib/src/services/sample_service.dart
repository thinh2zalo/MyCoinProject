import 'dart:async';
import 'dart:convert';

import 'package:data/src/responses/transaction_response.dart';

import '../responses/response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import 'interfaces/interfaces.dart';

Map<String, dynamic> _getMap(dynamic data) {
  if (data is Map) return data as Map<String, dynamic>;
  return json.decode(data.toString()) as Map<String, dynamic>;
}

class SampleService implements ISampleService {
  final IRestUtility _rest;

  SampleService() : _rest = GetIt.I.get<IRestUtility>(instanceName: 'SAMPLE');

  @override
  Future<SampleResultResponse<SampleResponse>> fetchProduct() async {
    final response = await _rest.request('products', Method.GET);
    return SampleResultResponse.fromJson(_getMap(response.data))
      ..statusCode = response.statusCode;
  }

  @override
  Future<SampleResultResponse<AccountResponse>> createNewWallet(
      String account) async {
    final response = await _rest.request(
        'http://localhost:3001/new-wallet', Method.POST,
        data: {'account': account});
    return SampleResultResponse<AccountResponse>.fromJson(
        _getMap(response.data))
      ..statusCode = response.statusCode;
  }

  @override
  Future<SampleResultResponse<AccountDataResponse>> getAccountAdress(
      String account) async {
    final response = await _rest.request(
        'http://localhost:3001/address/$account', Method.GET);
    return SampleResultResponse<AccountDataResponse>.fromJson(
        _getMap(response.data))
      ..statusCode = response.statusCode;
  }

  @override
  Future<SampleResultResponse<BaseResponse>> sendCoin(
      {String privateKey, String sender, int amount, String recipient}) async {
    final param = {
      'privKey': privateKey,
      'sender': sender,
      'recipient': recipient,
      'amount': amount,
    };
    final response = await _rest.request(
        'http://localhost:3001/transaction-broadcast', Method.POST,
        data: param);
    return null;
  }

  @override
  Future<SampleResultResponse<TransactionResponse>>
      fetchPendingTransaction() async {
    final response = await _rest.request(
      'http://localhost:3001/pendingTransactions',
      Method.GET,
    );
    return SampleResultResponse<TransactionResponse>.fromJson(
        _getMap(response.data))
      ..statusCode = response.statusCode;
  }

  @override
  Future<bool> mine() async {
    final response = await _rest.request(
      'http://localhost:3001/mine',
      Method.GET,
    );
    return true;
  }
}
