import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
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
                // 单击单选
                onTap: () {
                  if (!emojiTag.isSelected) {
                    ref.read(emojiTagListProvider.notifier).selectTag(emojiTag);
                  } else {
                    ref
                        .read(emojiTagListProvider.notifier)
                        .removeSelectTag(emojiTag);
                  }
                },
                // 长按多选
                onLongPress: () {
                  ref
                      .read(emojiTagListProvider.notifier)
                      .selectTag(emojiTag, single: false);
                },
                child: Chip(
                  avatar: emojiTag.isSelected ? const Icon(Icons.check) : null,
                  label: Text(emojiTag.name),
                ),
              ),
            )
        ],
      ),
    );
  }
}
