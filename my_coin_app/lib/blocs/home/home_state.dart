class HomeState {
  List<Account> listAccount;

  HomeState({
    List<Account> listAccount,
  }) : listAccount = listAccount ?? [];

  HomeState copyWith({
    List<Account> listAccount2,
  }) {
    return HomeState(listAccount: listAccount2 ?? this.listAccount);
  }
}

class Account {
  final String privateKey;
  final String publicKey;

  Account({this.privateKey, this.publicKey});
}
