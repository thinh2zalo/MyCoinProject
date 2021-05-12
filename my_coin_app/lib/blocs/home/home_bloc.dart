import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final ISampleBusiness _business;
  var db = new DatabaseHelper();

  HomeBloc(this._business) : super(state: HomeState());

  final _controller = BehaviorSubject<HomeState>.seeded(HomeState());

  HomeState get latestState => _controller.stream.value;

  Stream<List<AccountModel>> get listAccount$ =>
      _controller.stream.map((event) => event.listAccount);

  void createWallet(String account) async {
    final listAccount = await db.getUser();
    _controller.add(latestState.copyWith(listAccount: listAccount));
  }

  Future<void> loadData() async {
    final listAccount = await db.getUser();
    List<AccountModel> listAccountWithData = [];
    for (AccountModel account in listAccount) {
      final accountData = await getInforAccount(account.publicKey);
      listAccountWithData.add(account.coppyWith(amount: accountData.balance));
    }
    _controller.add(latestState.copyWith(listAccount: listAccountWithData));
  }

  Future<AccountDataResponse> getInforAccount(String address) async {
    final response = await _business.getAccountData(address);
    return response.items[0];
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
