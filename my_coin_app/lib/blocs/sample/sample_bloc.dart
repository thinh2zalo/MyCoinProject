import 'package:data/data.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

class SampleBloc extends BaseBloc<List<SampleModel>> {
  final ISampleBusiness _business;
  SampleBloc(this._business) : super(state: <SampleModel>[]);

  Future loadData() async {
    print('load data');
  }

  Future reload() async {
    waiting.add(true);
    await Future.delayed(Duration(seconds: 1));
    final entities = await _business.list();
    final models = entities?.map((entity) => entity.toModel())?.toList();
    waiting.add(false);
    emit(models);
  }
}
