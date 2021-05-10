// import 'package:data/data.dart';
// import 'package:flutter_sdk/flutter_sdk.dart';
// import '../../models/model.dart';

// class SampleDetailBloc extends BaseBloc<SampleEntity> {
//   SampleDetailBloc(this._business);

//   final ISampleBusiness _business;

//   Future<void> loadData(String id) async {
//     loading.add(true);
//     await Future.delayed(Duration(seconds: 1));
//     final entity = await _business.getById(id);
//     loading.add(false);

//     emit(entity);
//   }

//   Future<void> delete() async {
//     waiting.add(true);
//     await Future.delayed(Duration(seconds: 1));
//     await _business.delete(state);
//     waiting.add(false);

//     listener.add(EventModel(message: 'message.remove_success', success: true));
//   }

//   Future<void> update() async {
//     waiting.add(true);
//     await Future.delayed(Duration(seconds: 1));
//     await _business.update(SampleEntity(
//       id: state.id,
//       productName: '${state.productName} ${DateTime.now().second}',
//       image: state.image,
//       description: state.description,
//       regularPrice: state.regularPrice,
//       salePrice: state.salePrice,
//     ));

//     final entity = await _business.getById(state.id);
//     waiting.add(false);

//     emit(entity);
//   }
// }
