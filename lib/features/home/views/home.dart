import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojis = ref.watch(emojisProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('表情包 ${emojis.value?.length ?? ""}'),
      ),
      body: const Column(
        children: [
          EmojiDirTile(),
          Expanded(child: EmojiGridView()),
        ],
      ),
    );
  }
}
