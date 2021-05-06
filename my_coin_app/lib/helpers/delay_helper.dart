class DelayHelper {
  DelayHelper._();

  static Duration defaultDuration = const Duration(milliseconds: 250);

  static Future<void> defaultDelay() async => await Future.delayed(const Duration(milliseconds: 200));

  static Future<void> delayHalfSecond() async => await Future.delayed(const Duration(milliseconds: 500));

  static Future<void> delay1second() async => await Future.delayed(const Duration(seconds: 1));

  static Future<void> delay2second() async => await Future.delayed(const Duration(seconds: 2));
}
