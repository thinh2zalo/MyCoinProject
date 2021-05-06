extension StringExtension on String {
  bool parseBool() {
    final value = (this ?? '').toLowerCase();
    return value == 'true' || value == '1';
  }
}
