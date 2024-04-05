import 'package:emoji_room/features/emoji_search/providers/emoji_search.provider.dart';
import 'package:emoji_room/utils/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiSearchAppBar extends ConsumerWidget {
  const EmojiSearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keywordProvider = ref.watch(emojiSearchControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: TextField(
        controller: keywordProvider.keywordTec,
        focusNode: keywordProvider.focusNode,
        onChanged: (value) => ref
            .read(emojiSearchControllerProvider.notifier)
            .updateKeyword(value),
        decoration: InputDecoration(
          hintText: '搜索',
          prefixIcon: const Icon(Icons.search),
          suffix: _buildClearButton(context, ref),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(99),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ),
    );
  }

  _buildClearButton(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(99),
            onTap: () {
              ref.read(emojiSearchControllerProvider.notifier).clearKeyword();
              KeyBoardControl.cancelKeyBoard(context);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.black12, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}
