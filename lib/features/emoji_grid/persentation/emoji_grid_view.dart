import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_detail/views/emoji_detail.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:emoji_room/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiGridView extends ConsumerWidget {
  const EmojiGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojis = ref.watch(emojisProvider);

    return emojis.when(
      data: (emojis) => RefreshIndicator(
        onRefresh: () => ref.refresh(emojisProvider.future),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100),
          itemCount: emojis.length,
          itemBuilder: (context, index) {
            final emoji = emojis[index];
            if (emoji.file == null) return const SizedBox();
            return InkWell(
              borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
              onTap: () => showCommonModalBottomSheet(
                  context: context,
                  builder: (context) => EmojiDetailView(emoji)),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.emojiRadius),
                  child: Image.file(emoji.file!, fit: BoxFit.fitHeight),
                ),
              ),
            );
          },
        ),
      ),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
