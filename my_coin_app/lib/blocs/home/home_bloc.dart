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
      _controller.stream.map((event) {
        return event.pendingTransaction;
      });

  Stream<int> get total => _controller.stream.map((event) {
        return event.total;
      });

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
    var total = 0;
    for (AccountModel account in listAccount) {
      final accountData = await getInforAccount(account.publicKey);
      total = total + accountData.balance;
      listAccountWithData.add(account.coppyWith(
        amount: accountData.balance,
        listTransaaction: accountData.listTransaction,
      ));
    }
    _controller.add(
        latestState.copyWith(listAccount: listAccountWithData, total: total));
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

  Future<void> mining() async {
    final response = await _business.mining();
    loadData();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
