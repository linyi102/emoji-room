import 'dart:io';

import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'current_emoji.provider.g.dart';

@riverpod
class CurrentEmoji extends _$CurrentEmoji {
  @override
  Emoji build(Emoji emoji) {
    return emoji;
  }

  Future<void> share() async {
    final filePath = state.file.path;
    if (Platform.isAndroid) {
      // ignore: deprecated_member_use
      await Share.shareFiles([filePath]);
    } else if (Platform.isWindows) {
      // BUG: 直接写入图片时，会在最近复制的文本后面追加图片，导致粘贴后存在文本和图片
      // 临时解决方法：先写入空白文本，再写入图片
      Pasteboard.writeText('');
      await Pasteboard.writeFiles([filePath]);
    }

    final index = ref.read(emojisProvider).value?.indexOf(state);
    state = state.copyWith(usageCount: state.usageCount + 1);
    if (index != null && index >= 0) {
      ref.read(emojisProvider).value?[index] = state;
    }
  }

  void modTitle(String title) {
    state = state.copyWith(title: title);
  }
}
