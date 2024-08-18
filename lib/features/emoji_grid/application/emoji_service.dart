import 'dart:io';

import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_dir/providers/scan_qq.provider.dart';
import 'package:emoji_room/features/emoji_grid/data/emoji_repository.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/features/emoji_search/providers/emoji_search.provider.dart';
import 'package:emoji_room/features/emoji_sort/providers/emoji_sort_provider.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/utils/permission.dart';
import 'package:emoji_room/utils/string.dart';
import 'package:emoji_room/utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'emoji_service.g.dart';

class EmojiService {
  final Ref ref;
  EmojiService(this.ref);

  Future<List<Emoji>> fetchEmojis({
    bool cache = true,
    List<String> keywords = const [],
  }) async {
    if (!await tryRequestManageExternalStorage()) {
      return [];
    }

    final scanQQ = ref.watch(scanQQProvider);
    final emojis = ref.watch(emojiRepositoryProvider).fetchEmojis(
          cache: cache,
          scanQQ: scanQQ,
          keywords: keywords,
        );
    return emojis;
  }

  Future<bool> tryRequestManageExternalStorage() async {
    bool? hasPermission = await PermissionUtil.hasManageExternalStorage();
    if (hasPermission) return true;

    hasPermission = await ToastUtil.showDialog<bool>(
      builder: (close) => AlertDialog(
        title: const Text('提示'),
        content: const Text('需要申请管理文件权限来保存配置，是否前往设置页授予权限？'),
        actions: [
          TextButton(
              onPressed: () async {
                final hasPermission =
                    await PermissionUtil.requestManageExternalStorage();
                if (hasPermission) close(result: true);
              },
              child: const Text('前往')),
          TextButton(onPressed: close, child: const Text('取消')),
        ],
      ),
    );
    return hasPermission ?? false;
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
  bool cache = false;

  @override
  Future<List<Emoji>> build() async {
    final service = ref.watch(emojiServiceProvider);
    final keywords = ref.watch(searchKeywordsProvider);
    final emojis = await service.fetchEmojis(
      keywords: keywords,
      cache: cache,
    );
    final sortOption = ref.watch(emojiSortOptionProvider);
    final sortedEmojis = sortOption.mode.sortFn(emojis, sortOption.isReverse);

    cache = true;
    return Future.value(sortedEmojis);
  }

  Future<List<Emoji>> refresh() {
    cache = false;
    final res = ref.refresh(emojiListProvider.future);
    return res;
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

@Riverpod(keepAlive: true)
List<String> searchKeywords(Ref ref) {
  final selectedTags = ref.watch(selectedEmojiTagListProvider);
  final searchKeyword =
      ref.watch(emojiSearchControllerProvider.select((value) => value.keyword));

  return [
    ...selectedTags.map((e) => e.name),
    ...StringUtil.splitKeywords(searchKeyword)
  ];
}

@riverpod
int emojiTotal(Ref ref) {
  final emojis = ref.watch(emojiListProvider);
  return emojis.value?.length ?? 0;
}
