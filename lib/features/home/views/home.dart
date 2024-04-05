import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:emoji_room/features/emoji_search/views/emoji_search_appbar.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tag_list_view.dart';
import 'package:emoji_room/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiTotal = ref.watch(emojiTotalProvider);
    final brightness = ref.watch(themeBrightnessProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('表情包 ${emojiTotal == 0 ? '' : emojiTotal}'),
        actions: [
          IconButton(
            isSelected: brightness == Brightness.dark,
            onPressed: ref.read(themeBrightnessProvider.notifier).toggle,
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.brightness_2_outlined),
          ),
        ],
      ),
      body: const Column(
        children: [
          EmojiSearchAppBar(),
          EmojiDirTile(),
          EmojiTagsView(),
          Expanded(child: EmojiGridView()),
        ],
      ),
    );
  }
}
