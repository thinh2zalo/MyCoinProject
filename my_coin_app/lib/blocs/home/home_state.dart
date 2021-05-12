import 'package:data/data.dart';

class HomeState {
  List<AccountModel> listAccount;
  List<TransactionResponse> pendingTransaction;
  int total;

  HomeState(
      {List<AccountModel> listAccount,
      List<TransactionResponse> pendingTransaction,
      int total})
      : listAccount = listAccount ?? [],
        pendingTransaction = pendingTransaction ?? [],
        total = total;

  HomeState copyWith({
    List<AccountModel> listAccount,
    List<TransactionResponse> pendingTransaction,
    int total,
  }) {
    return HomeState(
        listAccount: listAccount ?? this.listAccount,
        pendingTransaction: pendingTransaction ?? this.pendingTransaction,
        total: total ?? this.total);
  }
}
