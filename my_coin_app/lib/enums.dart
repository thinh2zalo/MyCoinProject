enum AppTheme { light, dark, system }
enum SupportedFont { SFPro }
enum ImageSourceType { network, asset, local }
enum Environment { dev, staging }
enum Language { vi, en }
enum CheckStatus { WAITING, CONFORMED, ACTIVATED }
enum ActionType { create, update }

enum Gender { MALE, FEMALE, UNDEFINED }
enum ActionResident { UPDATE_INFO, REPORT_PROBLEMS, REMOVE_RESIDENT }
enum Relationship {
  GRAND_FATHER,
  GRAND_MOTHER,
  FATHER,
  MOTHER,
  WIFE,
  HUSBAND,
  BROTHER,
  SISTER,
  YOUNGER_SISTER,
  YOUNGER_BROTHER,
  SON,
  GRANDCHILDREN,
  OWNER,
  GUEST,
  TENANT,
  FRIEND,
  OTHER
}
enum ResidentStatus { REGISTERED, PROCESSING, REFUSE, UPDATING, UNKNOWN }

enum HomeService {
  QUESTION_AND_REPORT,
  BILLING_AND_PAYMENT,
  PROMOTION_AND_SALE_OFF,
  UTILITIES_AND_SERVICES,
  COMMUNITY_AND_LIFE,
  RESIDENT,
  PARKING_AND_VEHICLE,
  COMPLAIN_FEEDBACK,
}

enum HomeUtilities {
  services,
  billing,
  feedback,
  resident,
  parking,
}

extension EnvironmentExt on Environment {
  String get value => ['dev', 'stage'][index];
}

extension AppThemeExt on AppTheme {
  String get value => ['light', 'dark', 'system'][index];
}

extension ImageSourceTypeExt on ImageSourceType {
  String get value => ['network', 'asset', 'local'][index];
}

extension LanguageExt on Language {
  String get value => ['vi', 'en'][index];
}

extension SupportedFontExt on SupportedFont {
  String get value => ['SFPro'][index];
}

extension ActionTypeExt on ActionType {
  String get value => [
        'create',
        'update',
      ][index];
}
