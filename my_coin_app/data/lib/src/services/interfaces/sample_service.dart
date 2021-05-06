import '../../responses/response.dart';

abstract class ISampleService {
  Future<SampleResultResponse<SampleResponse>> fetchProduct();
}