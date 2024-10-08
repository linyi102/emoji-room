import 'package:animations/animations.dart';
import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_detail/views/emoji_detail.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/utils/keyboard.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiGridItem extends ConsumerWidget {
  const EmojiGridItem(this.emoji, {super.key});
  final Emoji emoji;
  bool get useBottomSheetStyle => false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
      onTap: () => showDetailView(context, emoji),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
          child: Image.file(
            emoji.file,
            fit: BoxFit.cover,
            cacheHeight: 300,
          ),
        ),
      ),
    );
  }

  Future<dynamic> showDetailView(BuildContext context, Emoji emoji) {
    KeyBoardControl.cancelKeyBoard(context);
    if (useBottomSheetStyle) {
      return showCommonModalBottomSheet(
        context: context,
        builder: (context) => Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: EmojiDetailView(emoji.id),
        ),
      );
    } else {
      return showModal(
        context: context,
        builder: (context) => AlertDialog(content: EmojiDetailView(emoji.id)),
      );
    }
  }
}
