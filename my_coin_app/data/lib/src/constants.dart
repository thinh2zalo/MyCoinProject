class HttpStatusCode {
  static const int success = 200;
  static const int badRequest = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int internalServerError = 500;
}

class ResultStatus {
  static const String success = 'Success';
  static const String failed = 'Failed';
}

class SharedPreferencesKey {
  static const String language = 'language';
  static const String theme = 'theme';
  static const String fcmToken = 'fcm_token';
  static const String pinCode = 'pin_code';
  static const String phoneNumber = 'phone_number';
  static const String residentInfo = 'resident_info';
  static const String selectedApartment = 'selectedApartment';
  static const String selectedApartmentId = 'selected_apartment_id';
  static const String userInfo = 'userInfo';
  static const String owner = 'owner';
  static const String refreshExpiresIn = 'refresh_expires_in';
}

class NetworkConstants {
  static const int pageSize = 10;
  static const String nullString = '';
}

class ImageQuality {
  static const int quality = 50;
}

class DateFormatConstants {
  static const String formatddMMyyyy = 'dd/MM/yyyy';
  static const String formatyyyyMMdd = 'yyyy-MM-dd';
  static const String formatHHmmddMMyyyy = 'HH:mm dd/MM/yyyy';
}

class AuthCode {
  static const String disable = "DISABLE";
  static const String firstLogin = "FIRST_LOGIN";
  static const String newDeviceId = "NEW_DEVICE_ID";
  static const String oldDeviceId = "OLD_DEVICE_ID";
  static const String invalidPhoneNumber = "INVALID_PHONE_NUMBER";
}
