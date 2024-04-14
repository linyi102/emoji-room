import 'dart:io';

import 'package:emoji_room/features/emoji_detail/providers/current_emoji.provider.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/features/emoji_title_edit/views/emoji_title_edit_page.dart';
import 'package:emoji_room/routing/router.dart';
import 'package:emoji_room/utils/file.dart';
import 'package:emoji_room/widgets/emoji_detail_image.dart';
import 'package:emoji_room/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiDetailView extends ConsumerWidget {
  const EmojiDetailView(this.emojiId, {super.key});
  final String emojiId;

  double get emojiSize => 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emoji = ref.watch(currentEmojiProvider(emojiId));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EmojiDetailImage(emoji),
        const GapH(8),
        _buildTitle(emoji, context),
        const GapH(2),
        _buildSize(emoji, context),
        const GapH(20),
        Align(
            alignment: Alignment.center,
            child: _buildUsageCount(emoji, context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildShareBottomButton(emoji, context, ref),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(Emoji emoji, BuildContext context) {
    final title = emoji.title;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => RouteUtil.materialTo(context, EmojiTitleEditPage(emoji.id)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(title.isNotEmpty ? title : '添加标题',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Text _buildSize(Emoji emoji, BuildContext context) {
    return Text(
      FileUtil.getReadableFileSize(emoji.size),
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Theme.of(context).hintColor),
    );
  }

  Text _buildUsageCount(Emoji emoji, BuildContext context) {
    return Text(
      '已分享 ${emoji.usageCount} 次',
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Theme.of(context).hintColor),
    );
  }

  Padding _buildShareBottomButton(
      Emoji emoji, BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SizedBox(
        height: 40,
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )),
              backgroundColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
            ),
            onPressed: () {
              ref.read(emojiServiceProvider).shareEmoji(emoji);
              Navigator.pop(context);
            },
            child: Text(Platform.isAndroid ? '分享' : '复制')),
      ),
    );
  }
}
