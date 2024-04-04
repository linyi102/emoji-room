import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/data/emoji_repository.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_service.g.dart';

class EmojiService {
  final Ref ref;
  EmojiService(this.ref);

  Future<bool> pickEmojiDir() async {
    String? selectedDirPath = await FilePicker.platform.getDirectoryPath();
    if (selectedDirPath == null) return false;
    ref.read(emojiDirPathProvider.notifier).update(selectedDirPath);
    return true;
  }
}

@riverpod
EmojiService emojiService(Ref ref) {
  return EmojiService(ref);
}

@riverpod
Future<List<Emoji>> emojis(Ref ref) async {
  final dirPath = ref.watch(emojiDirPathProvider);
  if (dirPath == null || dirPath.isEmpty) return [];

  return ref.watch(emojiRepositoryProvider).fetchEmojis(dirPath);
}
