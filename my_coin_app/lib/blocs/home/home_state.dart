import 'package:data/data.dart';

class HomeState {
  List<AccountModel> listAccount;

  HomeState({
    List<AccountModel> listAccount,
  }) : listAccount = listAccount ?? [];

  HomeState copyWith({
    List<AccountModel> listAccount,
  }) {
    return HomeState(listAccount: listAccount ?? this.listAccount);
  }
}
