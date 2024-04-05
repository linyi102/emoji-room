class StringUtil {
  /// 空格分隔出关键字数组
  /// 示例
  /// 输入："ab cd   e"
  /// 输出：[ab, cd, e]
  static List<String> splitKeywords(String value) {
    return value.isNotEmpty ? value.split(RegExp(r'\s+')) : [];
  }
}
