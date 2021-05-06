import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sdk/flutter_sdk.dart';

import '../resources/resources.dart';

extension DateTimeExt on DateTime {
  static const fixLocale = 'vi';
  static const timeFormatHHMM = 'HH:mm';
  static const dateFormatMMMddYYY = 'MMM dd, yyyy';
  static const dateFormatddMMMMYYY = 'dd MMMM, yyyy';
  static const dateFormatddMMyyyy = 'dd/MM/yyyy';

  String get formatTimeHHMM => DateFormat(timeFormatHHMM, fixLocale).format(this);

  String get formatMMMddYYY => DateFormat(dateFormatMMMddYYY, fixLocale).format(this);
  
  String get formatddMMMMYYY => DateFormat(dateFormatddMMMMYYY, fixLocale).format(this);

  String get formatddMMyyyy => DateFormat(dateFormatddMMyyyy, fixLocale).format(this);

  String formatDateTime(String formatter) => DateFormat(formatter, fixLocale).format(this);

  DateTime get date => this == null ? null : DateTime(year, month, day);
}
