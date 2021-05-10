import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final ISampleBusiness _business;

  HomeBloc(this._business) : super(state: HomeState());

  void createWallet() async {
    await _business.createNewWallet();
  }
}
