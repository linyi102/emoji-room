import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
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
    if (state.file == null) return;

    // ignore: deprecated_member_use
    await Share.shareFiles([state.file!.path]);

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
