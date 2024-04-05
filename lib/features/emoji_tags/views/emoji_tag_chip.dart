import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:flutter/material.dart';

class EmojiTagChip extends StatelessWidget {
  const EmojiTagChip(
    this.emojiTag, {
    super.key,
  });
  final EmojiTag emojiTag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(emojiTag.name),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: emojiTag.isSelected
          ? BorderSide(color: Theme.of(context).colorScheme.primary)
          : const BorderSide(style: BorderStyle.none),
      labelStyle: emojiTag.isSelected
          ? TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer)
          : null,
      visualDensity: VisualDensity.compact,
    );
  }
}
