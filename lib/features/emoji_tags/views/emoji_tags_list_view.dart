import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiTagsListView extends ConsumerStatefulWidget {
  const EmojiTagsListView(this.providerListenable, {super.key});
  final ProviderListenable<List<EmojiTag>> providerListenable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmojiTagsListViewState();
}

class _EmojiTagsListViewState extends ConsumerState<EmojiTagsListView> {
  bool get dense => false;

  @override
  Widget build(BuildContext context) {
    final emojiTagList = ref.watch(widget.providerListenable);
    final selectedEmojiTagList = ref.watch(selectedEmojiTagListProvider);
    if (emojiTagList.isEmpty) return const SizedBox();

    return ListView.builder(
      itemCount: emojiTagList.length,
      itemBuilder: (context, index) {
        final tag = emojiTagList[index];
        final selected =
            selectedEmojiTagList.indexWhere((e) => e.name == tag.name) >= 0;
        return ListTile(
          dense: dense,
          title: Text(tag.name),
          leading: selected
              ? Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).primaryColor,
                  size: dense ? 20 : null,
                )
              : Icon(
                  Icons.radio_button_off,
                  size: dense ? 20 : null,
                ),
          trailing: Text(tag.count.toString()),
          onTap: () => toggleSelectTag(ref, tag),
          onLongPress: () => multiSelectTag(ref, tag),
        );
      },
    );
  }

  /// 多选
  void multiSelectTag(WidgetRef ref, EmojiTag emojiTag) {
    ref
        .read(selectedEmojiTagListProvider.notifier)
        .select(emojiTag, single: false);
  }

  /// 单选或取消
  void toggleSelectTag(WidgetRef ref, EmojiTag emojiTag) {
    ref.read(selectedEmojiTagListProvider.notifier).toggleTag(emojiTag);
  }
}
