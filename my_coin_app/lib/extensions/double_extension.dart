import 'package:intl/intl.dart';

extension DoubleExtensions on double {
  String toViMoneyString() {
    final formatter = new NumberFormat.simpleCurrency(locale: 'vi');
    return formatter.format(this);
  }
}
