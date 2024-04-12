import 'package:emoji_room/constants/app_theme.dart';
import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/features/emoji_tags/providers/emoji_tag_list.provider.dart';
import 'package:emoji_room/features/emoji_tags/views/emoji_tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiTagsWrapView extends ConsumerWidget {
  const EmojiTagsWrapView(this.providerListenable, {super.key});
  final ProviderListenable<List<EmojiTag>> providerListenable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiTagList = ref.watch(providerListenable);
    final selectedEmojiTagList = ref.watch(selectedEmojiTagListProvider);
    if (emojiTagList.isEmpty) return const SizedBox();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.centerLeft,
        child: Wrap(
          runSpacing: AppTheme.wrapRunSpacing,
          children: [
            for (final tag in emojiTagList)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: GestureDetector(
                  onTap: () => toggleSelectTag(ref, tag),
                  onLongPress: () => multiSelectTag(ref, tag),
                  child: EmojiTagChip(
                    tag,
                    selected: selectedEmojiTagList
                            .indexWhere((e) => e.name == tag.name) >=
                        0,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  /// 多选
  void multiSelectTag(WidgetRef ref, EmojiTag emojiTag) {
    ref
        .read(selectedEmojiTagListProvider.notifier)
        .select(emojiTag, single: false);
  }

  /// 单选或取消
  void toggleSelectTag(WidgetRef ref, EmojiTag emojiTag) {
    ref.read(selectedEmojiTagListProvider.notifier).toggleTag(emojiTag);
  }
}
