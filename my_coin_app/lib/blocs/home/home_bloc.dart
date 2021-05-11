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
    final result = await _business.createNewWallet(account);

    final listAccount = await db.getUser();
    _controller.add(latestState.copyWith(listAccount2: listAccount));
  }

  void loadData() {
    // SharedPreferences.
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
