import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/persentation/emoji_grid_view.dart';
import 'package:emoji_room/features/emoji_search/providers/emoji_search.provider.dart';
import 'package:emoji_room/features/emoji_search/views/emoji_search_bar.dart';
import 'package:emoji_room/features/emoji_sort/views/emoji_sort_setting_view.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_grid_view.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tags_wrap_view.dart';
import 'package:emoji_room/features/settings/views/setting_view.dart';
import 'package:emoji_room/utils/keyboard.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();
  final HotKey _searchHotKey = HotKey(
    KeyCode.keyF,
    modifiers: [KeyModifier.control],
    scope: HotKeyScope.inapp,
  );
  bool showSearchAction = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _setShowSearchAction(_scrollController.position.pixels > 0);
    });
    hotKeyManager.register(
      _searchHotKey,
      keyDownHandler: (hotKey) => _focusSearchField(),
    );
  }

  void _setShowSearchAction(bool visible) {
    if (visible == showSearchAction) return;
    setState(() {
      showSearchAction = visible;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    hotKeyManager.unregister(_searchHotKey);
  }

  @override
  Widget build(BuildContext context) {
    final emojiDirPath = ref.watch(emojiDirPathProvider);
    final emojiTotal = ref.watch(emojiTotalProvider);

    bool hasSelectMainDir = emojiDirPath != null && emojiDirPath.isNotEmpty;

    return WillPopScope(
      onWillPop: () async => clearInputFocusAndSearchKeyword(ref, context),
      child: RefreshIndicator(
        onRefresh: () => ref.read(emojiListProvider.notifier).refresh(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar.large(
              snap: false,
              title: Text('表情包 ${emojiTotal == 0 ? '' : emojiTotal}'),
              actions: _buildActions(context),
            ),
            if (!hasSelectMainDir)
              const SliverToBoxAdapter(child: EmojiDirTile())
            else ...[
              const SliverToBoxAdapter(child: EmojiSearchBar()),
              SliverToBoxAdapter(
                  child: EmojiTagsWrapView(selectedEmojiTagListProvider)),
              const EmojiGridView(),
            ]
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      AnimatedScale(
        scale: showSearchAction ? 1 : 0,
        duration: kThemeAnimationDuration,
        curve: Curves.easeInCubic,
        child: IconButton(
            onPressed: _focusSearchField, icon: const Icon(Icons.search)),
      ),
      IconButton(
          onPressed: () => _showSortOptionView(context, ref),
          icon: const Icon(Icons.filter_list_rounded)),
      IconButton(
          onPressed: () => _showAllTagView(context, ref),
          icon: const Icon(Icons.label_outline_sharp)),
      IconButton(
          onPressed: () {
            showCommonModalBottomSheet(
              context: context,
              builder: (context) => const SettingView(),
            );
          },
          icon: const Icon(Icons.settings_outlined)),
    ];
  }

  void _focusSearchField() {
    _scrollController.jumpTo(0);
    final provider = ref.read(emojiSearchControllerProvider);
    provider.focusNode.requestFocus();
    provider.keywordTec.selection = TextSelection(
      baseOffset: 0,
      extentOffset: provider.keywordTec.text.length,
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

  Future<dynamic> _showSortOptionView(BuildContext context, WidgetRef ref) {
    return showCommonModalBottomSheet(
      context: context,
      builder: (context) => const EmojiSortSettingView(),
    );
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
