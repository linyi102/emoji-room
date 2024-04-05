import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_detail/views/emoji_detail.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiGridItem extends ConsumerWidget {
  const EmojiGridItem(this.emoji, {super.key});
  final Emoji emoji;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
      onTap: () => showDetailView(context, emoji),
      onLongPress: () => shareEmoji(ref, emoji, context),
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

  Future<void> shareEmoji(WidgetRef ref, Emoji emoji, BuildContext context) =>
      ref.read(emojiServiceProvider).shareEmoji(emoji);

  Future<dynamic> showDetailView(BuildContext context, Emoji emoji) {
    return showCommonModalBottomSheet(
        context: context, builder: (context) => EmojiDetailView(emoji.id));
  }
}
