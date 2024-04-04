import 'package:emoji_room/features/data/emoji_repository.dart';
import 'package:emoji_room/features/domain/emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_service.g.dart';

class EmojiService {
  final Ref ref;
  EmojiService(this.ref);

  Future<List<Emoji>> fetchEmojis() async {
    return ref.read(emojiRepositoryProvider).fetchEmojis();
  }
}

@riverpod
EmojiService emojiService(Ref ref) {
  return EmojiService(ref);
}

@riverpod
Future<List<Emoji>> emojis(Ref ref) {
  return ref.read(emojiRepositoryProvider).fetchEmojis();
}
