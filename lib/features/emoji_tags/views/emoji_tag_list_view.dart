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
                  // avatar: emojiTag.isSelected ? const Icon(Icons.check) : null,
                  label: Text(emojiTag.name),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: emojiTag.isSelected
                      ? BorderSide(color: Theme.of(context).primaryColor)
                      : const BorderSide(style: BorderStyle.none),
                  labelStyle: emojiTag.isSelected
                      ? TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)
                      : null,
                  // selectedColor: Theme.of(context).primaryColor,
                  // selected: emojiTag.isSelected,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            )
        ],
      ),
    );
  }
}
