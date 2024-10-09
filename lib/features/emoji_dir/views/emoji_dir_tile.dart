import 'dart:io';

import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/utils/windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiDirTile extends ConsumerWidget {
  const EmojiDirTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dirPath = ref.watch(emojiDirPathProvider);
    final hasConfigDirPath = dirPath?.trim().isNotEmpty == true;

    return ListTile(
      leading: const Icon(Icons.folder),
      title: const Text('选择主目录'),
      subtitle: hasConfigDirPath ? Text(dirPath ?? '') : null,
      onTap: ref.read(emojiServiceProvider).pickEmojiDir,
      trailing: !hasConfigDirPath || !Platform.isWindows
          ? null
          : IconButton(
              onPressed: () => WindowsUtil.openFileExplorer(dirPath),
              icon: const Icon(Icons.folder_open, size: 20),
            ),
    );
  }
}
