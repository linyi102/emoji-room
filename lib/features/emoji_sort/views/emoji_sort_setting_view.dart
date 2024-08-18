import 'package:emoji_room/features/emoji_sort/providers/emoji_sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiSortSettingView extends ConsumerWidget {
  const EmojiSortSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiSortOption = ref.watch(emojiSortOptionProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('排序'), automaticallyImplyLeading: false),
      body: ListView.builder(
        itemCount: EmojiSortMode.values.length,
        itemBuilder: (context, index) {
          final mode = EmojiSortMode.values[index];
          final selected = emojiSortOption.mode == mode;

          return ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: selected
                  ? emojiSortOption.isReverse
                      ? const Icon(Icons.arrow_downward)
                      : const Icon(Icons.arrow_upward)
                  : null,
            ),
            selected: selected,
            title: Text(mode.label),
            onTap: () {
              if (selected) {
                ref
                    .read(emojiSortOptionProvider.notifier)
                    .changeSortDirection(!emojiSortOption.isReverse);
              } else {
                ref.read(emojiSortOptionProvider.notifier).changeSortMode(mode);
              }
            },
          );
        },
      ),
    );
  }
}
