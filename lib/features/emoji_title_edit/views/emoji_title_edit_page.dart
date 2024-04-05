import 'package:emoji_room/features/emoji_detail/providers/current_emoji.provider.dart';
import 'package:emoji_room/features/emoji_grid/application/emoji_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiTitleEditPage extends ConsumerWidget {
  const EmojiTitleEditPage(this.emojiId, {super.key});
  final String emojiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emoji = ref.watch(currentEmojiProvider(emojiId));
    final TextEditingController titleTc =
        TextEditingController(text: emoji.title);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('编辑', style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
              onPressed: () {
                ref
                    .read(emojiListProvider.notifier)
                    .updateItem(emoji.copyWith(title: titleTc.text.trim()));
                Navigator.pop(context);
              },
              child: const Text('完成'))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: titleTc,
              autofocus: true,
              decoration: InputDecoration(
                labelText: '编辑标题',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
