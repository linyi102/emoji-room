import 'dart:io';

import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_detail/providers/current_emoji.provider.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/features/emoji_title_edit/views/emoji_title_edit_page.dart';
import 'package:emoji_room/routing/router.dart';
import 'package:emoji_room/utils/file.dart';
import 'package:emoji_room/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiDetailView extends ConsumerWidget {
  const EmojiDetailView(this.emoji, {super.key});
  final Emoji emoji;

  double get emojiSize => 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEmoji = ref.watch(currentEmojiProvider(emoji).notifier);
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildImage(currentEmoji),
              const GapH(8),
              _buildTitle(currentEmoji, context),
              const GapH(2),
              _buildSize(currentEmoji, context),
              const GapH(2),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: Alignment.center,
                child: _buildUsageCount(currentEmoji, context)),
            _buildShareBottomButton(currentEmoji, context),
          ],
        ));
  }

  Align _buildImage(CurrentEmoji currentEmoji) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: emojiSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
          child: Image.file(
            currentEmoji.emoji.file,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(CurrentEmoji currentEmoji, BuildContext context) {
    final title = currentEmoji.emoji.title;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () =>
          RouteUtil.materialTo(context, EmojiTitleEditPage(currentEmoji)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(title.isNotEmpty ? title : '添加标题',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Text _buildSize(CurrentEmoji currentEmoji, BuildContext context) {
    return Text(
      FileUtil.getReadableFileSize(currentEmoji.emoji.size),
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Theme.of(context).hintColor),
    );
  }

  Text _buildUsageCount(CurrentEmoji currentEmoji, BuildContext context) {
    return Text(
      '共分享了 ${currentEmoji.emoji.usageCount} 次',
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Theme.of(context).hintColor),
    );
  }

  Padding _buildShareBottomButton(
      CurrentEmoji currentEmoji, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
            onPressed: () {
              currentEmoji.share();
              Navigator.pop(context);
            },
            child: Text(Platform.isAndroid ? '分享' : '复制')),
      ),
    );
  }
}
