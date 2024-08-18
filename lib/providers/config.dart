import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'config.g.dart';

class Config {
  late Box box;
  Future<void> init() async {
    box = await Hive.openBox('config');
  }

  static const emojiDirPathKey = 'emoji_dir_path';
  String getEmojiDir() => box.get(emojiDirPathKey, defaultValue: '');
  Future<void> setEmojiDir(String dirPath) => box.put(emojiDirPathKey, dirPath);

  static const isDarkKey = 'isDark';
  bool getIsDark() => box.get(isDarkKey, defaultValue: false);
  Future<void> setIsDark(bool isDark) => box.put(isDarkKey, isDark);

  static const scanQQKey = 'scanQQ';
  bool getScanQQ() => box.get(scanQQKey, defaultValue: false);
  Future<void> setScanQQ(bool scan) => box.put(scanQQKey, scan);

  static const emojiSortModeKey = 'emojiSortMode';
  int getEmojiSortModeIndex() => box.get(emojiSortModeKey, defaultValue: 0);
  Future<void> setEmojiSortModeIndex(int index) =>
      box.put(emojiSortModeKey, index);

  static const emojiSortReverse = 'emojiSortReverse';
  bool getEmojiSortReverse() => box.get(emojiSortReverse, defaultValue: true);
  Future<void> setEmojiSortReverse(bool isReverse) =>
      box.put(emojiSortReverse, isReverse);
}

@Riverpod(keepAlive: true)
Config config(Ref ref) => throw UnimplementedError();
