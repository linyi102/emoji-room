import 'package:flutter/foundation.dart';

class Log {
  static String get time => DateTime.now().toString().substring(11);

  static void i<T>(T content, {Type? runTimeType}) {
    if (!kDebugMode) return;
    String typeStr = runTimeType == null ? "" : ":${runTimeType.toString()}";
    debugPrint('🟩[I$typeStr][$time]$content🟩');
  }

  static void d<T>(T content) {
    if (!kDebugMode) return;
    debugPrint('🟦[D][$time]$content🟦');
  }

  static void w<T>(T content) {
    if (!kDebugMode) return;
    debugPrint('🟨[W][$time]$content🟨');
  }

  static void e<T>(T content) {
    if (!kDebugMode) return;
    debugPrint('🟥[E][$time]$content🟥');
  }
}
