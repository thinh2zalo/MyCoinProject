import 'constants.dart';

enum BillStatus { unpaid, paid, out_date, unknown }

enum ReservationsStatus { SUCCESS, CANCEL, USED }
enum PaymentMethod { Momo, ZaloPay, CreditCard, ViettelPay }
enum VehicleType { MOTORBIKE, ELEC_BICYCLE, CAR, BICYCLE }
enum AuthStatus { DISABLE, FIRST_LOGIN, NEW_DEVICE_ID, OLD_DEVICE_ID, INVALID_PHONE_NUMBER, UNKNOWN, ERROR }

extension AuthStatusExtensions on AuthStatus {
  String get value => [AuthCode.disable, AuthCode.firstLogin, AuthCode.newDeviceId, AuthCode.oldDeviceId, AuthCode.invalidPhoneNumber][index];
}
