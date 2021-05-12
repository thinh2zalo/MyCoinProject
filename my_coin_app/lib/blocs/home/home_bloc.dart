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

  Stream<List<TransactionResponse>> get listTransaction$ =>
      _controller.stream.map((event) => event.pendingTransaction);

  void createWallet(String account) async {
    final res = await _business.createNewWallet(account);
    var accountModel = res.items[0].toModel();
    final accountData = await getInforAccount(res.items[0].publicKey);
    accountModel.coppyWith(amount: accountData.balance);

    _controller.add(latestState.copyWith(
        listAccount: latestState.listAccount..add(accountModel)));
  }

  Future<void> loadData() async {
    final listAccount = await db.getUser();
    List<AccountModel> listAccountWithData = [];
    for (AccountModel account in listAccount) {
      final accountData = await getInforAccount(account.publicKey);
      listAccountWithData.add(account.coppyWith(amount: accountData.balance));
    }
    _controller.add(latestState.copyWith(listAccount: listAccountWithData));
    fetchPendingTransaction();
  }

  Future<AccountDataResponse> getInforAccount(String address) async {
    final response = await _business.getAccountData(address);
    return response.items[0];
  }

  Future<void> sendCoin(
      {String privateKey, String sender, int amount, String recipient}) async {
    final response = _business.sendCoin(
        privateKey: privateKey,
        sender: sender,
        amount: amount,
        recipient: recipient);
  }

  Future<void> fetchPendingTransaction() async {
    final response = await _business.fetchPendingTransaction();
    final penddingTransaction = response.items;
    _controller
        .add(latestState.copyWith(pendingTransaction: penddingTransaction));
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
