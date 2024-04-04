import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'config.g.dart';

class Config {
  late Box box;
  Future<void> init() async {
    box = await Hive.openBox('config');
  }

  static const emojiDirPath = 'emoji_dir_path';
  String getEmojiDir() => box.get(emojiDirPath, defaultValue: '');
  Future<void> setEmojiDir(String dirPath) => box.put(emojiDirPath, dirPath);
}

@Riverpod(keepAlive: true)
Config config(Ref ref) => throw UnimplementedError();
