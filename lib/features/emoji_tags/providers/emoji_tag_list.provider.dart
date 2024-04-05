import 'package:emoji_room/constants/app_text.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_tag_list.provider.g.dart';

@Riverpod(keepAlive: true)
class EmojiTagList extends _$EmojiTagList {
  @override
  List<EmojiTag> build() {
    final emojis = ref.watch(emojiListProvider).value ?? [];
    Map<String, int> tagCnt = {};
    for (final emoji in emojis) {
      for (final tag in emoji.tags) {
        tagCnt[tag] = (tagCnt[tag] ?? 0) + 1;
      }
    }
    List<EmojiTag> emojiTags = [];
    for (final tagName in tagCnt.keys) {
      emojiTags.add(EmojiTag(name: tagName, count: tagCnt[tagName] ?? 0));
    }
    emojiTags.sort((a, b) => -a.count.compareTo(b.count));
    // 当存在标签和全部数量相同时，排序后全部标签不一定在首位，因此手动添加到第一个
    emojiTags.insert(
        0,
        EmojiTag(
            name: AppText.allTagName, count: emojis.length, isSelected: true));
    return emojiTags;
  }

  void selectTag(EmojiTag tag, {bool single = true}) {
    state = [
      for (final item in state)
        if (item.name == tag.name)
          item.copyWith(isSelected: true)
        else
          single && item.isSelected ? item.copyWith(isSelected: false) : item
    ];
  }

  void removeSelectTag(EmojiTag tag) {
    state = [
      for (final item in state)
        if (item.name == tag.name) item.copyWith(isSelected: false) else item
    ];
  }
}

@Riverpod(keepAlive: true)
List<EmojiTag> selectedEmojiTagList(Ref ref) {
  final list = ref.watch(emojiTagListProvider);
  return list.where((e) => e.isSelected).toList();
}
