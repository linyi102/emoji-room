import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:flutter/material.dart';

class EmojiDetailImage extends StatelessWidget {
  const EmojiDetailImage(this.emoji, {this.height = 150.0, super.key});
  final Emoji emoji;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
          child: Image.file(
            emoji.file,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
