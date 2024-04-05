import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_tag_list.provider.g.dart';

@Riverpod(keepAlive: true)
class EmojiTagList extends _$EmojiTagList {
  @override
  List<EmojiTag> build() {
    return [];
  }

  void set(List<EmojiTag> tags) {
    state = tags;
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
