import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:emoji_room/features/emoji_search/views/emoji_search_appbar.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_view.dart';
import 'package:emoji_room/features/settings/views/setting_view.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiDirPath = ref.watch(emojiDirPathProvider);
    final emojiTotal = ref.watch(emojiTotalProvider);

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
                showCommonModalBottomSheet(
                  context: context,
                  builder: (context) => const SettingView(),
                );
              },
              icon: const Icon(Icons.settings)),
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
}
