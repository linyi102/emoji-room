import 'package:emoji_room/extensions/list_extension.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef EmojiSortFn = List<Emoji> Function(List<Emoji> emojis, bool isReverse);

enum EmojiSortMode {
  created('创建时间', _sortByCreated),
  mostShared('最多分享', _sortByMostShared);

  final String label;
  final EmojiSortFn sortFn;
  const EmojiSortMode(this.label, this.sortFn);
}

List<Emoji> _sortByCreated(List<Emoji> emojis, bool isReverse) {
  final sorted = emojis.sorted((a, b) => a.fcTime.compareTo(b.fcTime));
  return isReverse ? sorted.reversed.toList() : sorted;
}

List<Emoji> _sortByMostShared(List<Emoji> emojis, bool isReverse) {
  final sorted = emojis.sorted((a, b) => a.usageCount.compareTo(b.usageCount));
  return isReverse ? sorted.reversed.toList() : sorted;
}

class EmojiSortOption {
  EmojiSortMode mode;
  bool isReverse;

  EmojiSortOption({
    required this.mode,
    this.isReverse = false,
  });

  EmojiSortOption copyWith({
    EmojiSortMode? mode,
    bool? isReverse,
  }) {
    return EmojiSortOption(
      mode: mode ?? this.mode,
      isReverse: isReverse ?? this.isReverse,
    );
  }
}

class EmojiSortOptionNotifier extends Notifier<EmojiSortOption> {
  @override
  EmojiSortOption build() {
    return EmojiSortOption(mode: EmojiSortMode.created, isReverse: true);
  }

  void changeSortMode(EmojiSortMode mode) {
    state = state.copyWith(mode: mode);
  }

  void changeSortDirection(bool isReverse) {
    state = state.copyWith(isReverse: isReverse);
  }
}

final emojiSortOptionProvider =
    NotifierProvider<EmojiSortOptionNotifier, EmojiSortOption>(
        EmojiSortOptionNotifier.new);
