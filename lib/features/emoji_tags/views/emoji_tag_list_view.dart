import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiTagsView extends ConsumerWidget {
  const EmojiTagsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiTagList = ref.watch(emojiTagListProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          for (final emojiTag in emojiTagList)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () => toggleSelectTag(emojiTag, ref),
                onLongPress: () => multiSelectTag(ref, emojiTag),
                child: EmojiTagChip(emojiTag),
              ),
            )
        ],
      ),
    );
  }

  /// 多选
  void multiSelectTag(WidgetRef ref, EmojiTag emojiTag) {
    ref.read(emojiTagListProvider.notifier).selectTag(emojiTag, single: false);
  }

  /// 单选或取消
  void toggleSelectTag(EmojiTag emojiTag, WidgetRef ref) {
    if (!emojiTag.isSelected) {
      ref.read(emojiTagListProvider.notifier).selectTag(emojiTag);
    } else {
      ref.read(emojiTagListProvider.notifier).removeSelectTag(emojiTag);
    }
  }
}
