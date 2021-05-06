import '../responses/response.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../../data.dart';
import 'interfaces/sample_business.dart';

class SampleBusiness extends BaseBusiness<SampleEntity>
    implements ISampleBusiness {
  final ISampleService _service;

  SampleBusiness(ISampleRepository repository, this._service)
      : super(repository);

  @override
  Future<SampleResultResponse<SampleResponse>> fetchProduct() async {
    final response = await _service.fetchProduct();
    if (response.success) {
      final entities = response.items?.map((item) => item.toEntity())?.toList();
      batchInsertOrUpdate(entities);
    }
    return response;
  }
}