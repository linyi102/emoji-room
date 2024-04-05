import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiDirTile extends ConsumerWidget {
  const EmojiDirTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dirPath = ref.watch(emojiDirPathProvider);
    return ListTile(
      title: const Text('选择主目录'),
      subtitle: Text(dirPath ?? '未选择'),
      onTap: ref.read(emojiServiceProvider).pickEmojiDir,
    );
  }
}
