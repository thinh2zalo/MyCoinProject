import 'package:data/data.dart';

class HomeState {
  List<AccountModel> listAccount;

  HomeState({
    List<AccountModel> listAccount,
  }) : listAccount = listAccount ?? [];

  HomeState copyWith({
    List<AccountModel> listAccount2,
  }) {
    return HomeState(listAccount: listAccount2 ?? this.listAccount);
  }
}
