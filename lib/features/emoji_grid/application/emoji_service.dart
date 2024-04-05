import 'dart:io';

import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/data/emoji_repository.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'emoji_service.g.dart';

class EmojiService {
  final Ref ref;
  EmojiService(this.ref);

  Future<List<Emoji>> fetchEmojis() async {
    final emojis = await ref.watch(emojiRepositoryProvider).fetchEmojis();

    Map<String, int> tagCnt = {};
    for (final emoji in emojis) {
      for (final tag in emoji.tags) {
        tagCnt[tag] = tagCnt[tag] ?? 0 + 1;
      }
    }
    List<EmojiTag> emojiTags = [];
    for (final tagName in tagCnt.keys) {
      emojiTags.add(EmojiTag(name: tagName, count: tagCnt[tagName] ?? 0));
    }
    ref.read(emojiTagListProvider.notifier).set(emojiTags);
    return emojis;
  }

  Future<bool> pickEmojiDir() async {
    String? selectedDirPath = await FilePicker.platform.getDirectoryPath();
    if (selectedDirPath == null) return false;
    ref.read(emojiDirPathProvider.notifier).update(selectedDirPath);
    return true;
  }

  Future<void> shareEmoji(Emoji emoji) async {
    final filePath = emoji.file.path;
    if (Platform.isAndroid) {
      // ignore: deprecated_member_use
      await Share.shareFiles([filePath]);
    } else if (Platform.isWindows) {
      // BUG: 直接写入图片时，会在最近复制的文本后面追加图片，导致粘贴后存在文本和图片
      // 临时解决方法：先写入空白文本，再写入图片
      Pasteboard.writeText('');
      await Pasteboard.writeFiles([filePath]);
      ToastUtil.showText('已复制到剪切板');
    }

    final newEmoji = emoji.copyWith(usageCount: emoji.usageCount + 1);
    ref.read(emojiListProvider.notifier).updateItem(newEmoji);
  }
}

@Riverpod(keepAlive: true)
EmojiService emojiService(Ref ref) {
  return EmojiService(ref);
}

@Riverpod(keepAlive: true)
class EmojiList extends _$EmojiList {
  @override
  FutureOr<List<Emoji>> build() {
    return ref.watch(emojiServiceProvider).fetchEmojis();
  }

  updateItem(Emoji newEmoji) {
    ref.read(emojiRepositoryProvider).saveEmoji(newEmoji);

    final emojis = state.value ?? [];
    state = AsyncData([
      for (final emoji in emojis)
        if (emoji.id == newEmoji.id)
          newEmoji.copyWith(mTime: DateTime.now())
        else
          emoji
    ]);
  }
}

@riverpod
Future<List<Emoji>> filteredEmojiList(Ref ref) async {
  final all = ref.watch(emojiListProvider).value ?? [];
  final selectedTags = ref.watch(selectedEmojiTagListProvider);
  return all.where((emoji) {
    for (final selectedTag in selectedTags) {
      if (!emoji.tags.contains(selectedTag.name)) {
        return false;
      }
    }
    return true;
  }).toList();
}

@riverpod
int emojiTotal(Ref ref) {
  final emojis = ref.watch(emojiListProvider);
  return emojis.value?.length ?? 0;
}
