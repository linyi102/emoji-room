import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiTagsGridView extends ConsumerStatefulWidget {
  const EmojiTagsGridView(this.providerListenable, {super.key});
  final ProviderListenable<List<EmojiTag>> providerListenable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmojiTagsListViewState();
}

class _EmojiTagsListViewState extends ConsumerState<EmojiTagsGridView> {
  bool get dense => false;

  @override
  Widget build(BuildContext context) {
    final emojiTagList = ref.watch(widget.providerListenable);
    final selectedEmojiTagList = ref.watch(selectedEmojiTagListProvider);
    if (emojiTagList.isEmpty) return const SizedBox();
    const radius = 8.0;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      itemCount: emojiTagList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final tag = emojiTagList[index];
        final selected =
            selectedEmojiTagList.indexWhere((e) => e.name == tag.name) >= 0;
        return InkWell(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).hintColor.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    tag.name,
                    style: TextStyle(
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                  ),
                ),
                const GapW(5),
                Text(
                  tag.count.toString(),
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
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
