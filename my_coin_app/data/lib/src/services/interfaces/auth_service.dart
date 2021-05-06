import '../../responses/response.dart';

abstract class IAuthService {
  Future<ResultResponse<UserInfo>> fetchUserInfo();
}
