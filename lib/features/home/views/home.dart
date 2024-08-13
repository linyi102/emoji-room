import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:emoji_room/features/emoji_search/providers/emoji_search.provider.dart';
import 'package:emoji_room/features/emoji_search/views/emoji_search_appbar.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_grid_view.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_wrap_view.dart';
import 'package:emoji_room/features/settings/views/setting_view.dart';
import 'package:emoji_room/utils/keyboard.dart';
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

    return WillPopScope(
      onWillPop: () async => clearInputFocusAndSearchKeyword(ref, context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('表情包 ${emojiTotal == 0 ? '' : emojiTotal}'),
          actions: [
            IconButton(
                onPressed: () => _showAllTagView(context, ref),
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
                  EmojiTagsWrapView(selectedEmojiTagListProvider),
                  const Expanded(child: EmojiGridView()),
                ],
              ),
      ),
    );
  }

  bool clearInputFocusAndSearchKeyword(WidgetRef ref, BuildContext context) {
    final emojiSearchState = ref.read(emojiSearchControllerProvider);
    final emojiSelectedTags = ref.read(selectedEmojiTagListProvider);

    bool back = true;
    if (emojiSearchState.hasFocus) {
      back = false;
      KeyBoardControl.cancelKeyBoard(context);
    }
    if (emojiSearchState.keyword.isNotEmpty) {
      back = false;
      ref.read(emojiSearchControllerProvider.notifier).clearKeyword();
    }
    if (emojiSelectedTags.isNotEmpty) {
      back = false;
      ref.read(selectedEmojiTagListProvider.notifier).clearSelectedTags();
    }

    return back;
  }

  Future<dynamic> _showAllTagView(BuildContext context, WidgetRef ref) {
    return showCommonModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                '标签 ${ref.read(emojiTagListProvider).length}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(child: EmojiTagsGridView(emojiTagListProvider)),
          ],
        ),
      ),
    );
  }
}
