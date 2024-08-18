import 'package:emoji_room/extensions/list_extension.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/providers/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef EmojiSortFn = List<Emoji> Function(List<Emoji> emojis, bool isReverse);

enum EmojiSortMode {
  created('创建时间', _sortByCreated),
  recentShared('最近分享', _sortByRecentShared),
  mostShared('最多分享', _sortByMostShared);

  final String label;
  final EmojiSortFn sortFn;
  const EmojiSortMode(this.label, this.sortFn);
}

int _defaultSort(Emoji a, Emoji b) => a.fcTime.compareTo(b.fcTime);

List<Emoji> _sortByCreated(List<Emoji> emojis, bool isReverse) {
  final sorted = emojis.sorted((a, b) => a.fcTime.compareTo(b.fcTime));
  return isReverse ? sorted.reversed.toList() : sorted;
}

List<Emoji> _sortByRecentShared(List<Emoji> emojis, bool isReverse) {
  final sorted = emojis.sorted((a, b) {
    final aTime = a.shareRecords.lastOrNull;
    final bTime = b.shareRecords.lastOrNull;
    if (aTime != null && bTime != null) return aTime.compareTo(bTime);
    if (aTime != null) return 1;
    if (bTime != null) return -1;
    return _defaultSort(a, b);
  });
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
    final config = ref.watch(configProvider);
    return EmojiSortOption(
      mode: EmojiSortMode.values[config.getEmojiSortModeIndex()],
      isReverse: config.getEmojiSortReverse(),
    );
  }

  void changeSortMode(EmojiSortMode mode) {
    state = state.copyWith(mode: mode);
    ref
        .read(configProvider)
        .setEmojiSortModeIndex(EmojiSortMode.values.indexOf(mode));
  }

  void changeSortDirection(bool isReverse) {
    state = state.copyWith(isReverse: isReverse);
    ref.read(configProvider).setEmojiSortReverse(isReverse);
  }
}

final emojiSortOptionProvider =
    NotifierProvider<EmojiSortOptionNotifier, EmojiSortOption>(
        EmojiSortOptionNotifier.new);
