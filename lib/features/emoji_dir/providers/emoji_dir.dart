import 'package:emoji_room/providers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_dir.g.dart';

@Riverpod(keepAlive: true)
class EmojiDirPath extends _$EmojiDirPath {
  @override
  String? build() {
    return ref.watch(configProvider).getEmojiDir();
  }

  update(String dirPath) {
    ref.read(configProvider).setEmojiDir(dirPath);
    state = dirPath;
  }
}
