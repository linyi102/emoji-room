import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_emoji.provider.g.dart';

@riverpod
class CurrentEmoji extends _$CurrentEmoji {
  @override
  Emoji build(Emoji emoji) {
    return emoji;
  }

  void modTitle(String title) {
    state = state.copyWith(title: title);
  }
}
