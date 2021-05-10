import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final ISampleBusiness _business;

  HomeBloc(this._business) : super(state: HomeState());

  final _controller = BehaviorSubject<HomeState>.seeded(HomeState());

  HomeState get latestState => _controller.stream.value;

  Stream<List<Account>> get listAccount$ =>
      _controller.stream.map((event) => event.listAccount);

  SharedPreferences _prefs = SharedPreferences();

  void createWallet(String account) async {
    final result = await _business.createNewWallet(account);

    // _controller.add(latestState.copyWith()
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
