class TimerHelper {
  static String formatCountdown(int seconds) {
    if (seconds == null || seconds == 0) return '';
    final List<String> result = <String>[];
    final minutes = seconds ~/ 60; // 1 minute in seconds
    seconds -= minutes * 60;

    if (minutes > 0) {
      result.add('${_formatNumber(minutes)}');
    } else {
      result.add('0');
    }
    if (seconds > 0) {
      result.add('${_formatNumber(seconds)}');
    } else {
      result.add('00');
    }

    return result.join(':');
  }

  static String _formatNumber(int num) {
    if (num < 10 && num > -10) return '0$num';
    return '$num';
  }
}