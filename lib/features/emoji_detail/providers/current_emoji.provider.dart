import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_emoji.provider.g.dart';

@riverpod
Emoji currentEmoji(Ref ref, String id) {
  return ref.watch(emojiListProvider).value?.firstWhere((e) => e.id == id) ??
      Emoji.invalid();
}
