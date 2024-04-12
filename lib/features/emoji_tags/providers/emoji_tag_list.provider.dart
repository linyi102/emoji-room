import 'package:emoji_room/features/emoji_grid/data/emoji_repository.dart';
import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_tag_list.provider.g.dart';

@riverpod
class EmojiTagList extends _$EmojiTagList {
  @override
  List<EmojiTag> build() {
    return ref.watch(emojiRepositoryProvider).fetchEmojiTags();
  }
}

@Riverpod(keepAlive: true)
class SelectedEmojiTagList extends _$SelectedEmojiTagList {
  @override
  List<EmojiTag> build() {
    return [];
  }

  void toggleTag(EmojiTag tag) {
    if (hasSelected(tag)) {
      remove(tag);
    } else {
      select(tag);
    }
  }

  bool hasSelected(EmojiTag tag) {
    return state.indexWhere((e) => e.name == tag.name) >= 0;
  }

  void select(EmojiTag tag, {bool single = true}) {
    if (single) {
      state = [tag];
    } else {
      state = [...state, tag];
    }
  }

  void remove(EmojiTag tag) {
    state = state.where((e) => e.name != tag.name).toList();
  }

  void clearSelectedTags() {
    state = [];
  }
}
