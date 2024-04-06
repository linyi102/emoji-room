import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:emoji_room/features/emoji_search/views/emoji_search_appbar.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_view.dart';
import 'package:emoji_room/providers/theme.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiDirPath = ref.watch(emojiDirPathProvider);
    final emojiTotal = ref.watch(emojiTotalProvider);
    final brightness = ref.watch(themeBrightnessProvider);

    bool hasSelectMainDir = emojiDirPath != null && emojiDirPath.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text('表情包 ${emojiTotal == 0 ? '' : emojiTotal}'),
        actions: [
          IconButton(
              onPressed: () {
                showCommonModalBottomSheet(
                  context: context,
                  builder: (context) => EmojiTagsView(emojiTagListProvider),
                );
              },
              icon: const Icon(Icons.tag)),
          IconButton(
              onPressed: () {
                _showSettingBottomSheet(context);
              },
              icon: const Icon(Icons.settings)),
          IconButton(
            isSelected: brightness == Brightness.dark,
            onPressed: ref.read(themeBrightnessProvider.notifier).toggle,
            icon: const Icon(Icons.wb_sunny_outlined),
            selectedIcon: const Icon(Icons.brightness_2_outlined),
          ),
        ],
      ),
      body: !hasSelectMainDir
          ? const EmojiDirTile()
          : Column(
              children: [
                const EmojiSearchAppBar(),
                EmojiTagsView(selectedEmojiTagListProvider),
                const Expanded(child: EmojiGridView()),
              ],
            ),
    );
  }

  Future<dynamic> _showSettingBottomSheet(BuildContext context) {
    return showCommonModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
          automaticallyImplyLeading: false,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              EmojiDirTile(),
            ],
          ),
        ),
      ),
    );
  }
}
