import 'package:data/data.dart';

class HomeState {
  List<AccountModel> listAccount;
  List<TransactionResponse> pendingTransaction;

  HomeState({
    List<AccountModel> listAccount,
    List<TransactionResponse> pendingTransaction,
  })  : listAccount = listAccount ?? [],
        pendingTransaction = pendingTransaction ?? [];

  HomeState copyWith({
    List<AccountModel> listAccount,
    List<TransactionResponse> pendingTransaction,
  }) {
    return HomeState(
      listAccount: listAccount ?? this.listAccount,
      pendingTransaction: pendingTransaction ?? this.pendingTransaction,
    );
  }
}
