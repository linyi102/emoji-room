import 'package:emoji_room/features/application/emoji_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiGridViewPage extends ConsumerStatefulWidget {
  const EmojiGridViewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmojiGridViewPageState();
}

class _EmojiGridViewPageState extends ConsumerState<EmojiGridViewPage> {
  @override
  Widget build(BuildContext context) {
    final emojis = ref.watch(emojisProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('表情包'),
      ),
      body: emojis.when(
        data: (emojis) => RefreshIndicator(
          onRefresh: () => ref.refresh(emojisProvider.future),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100),
            itemCount: emojis.length,
            itemBuilder: (context, index) {
              final emoji = emojis[index];
              if (emoji.file == null) return const SizedBox();
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(emoji.file!, fit: BoxFit.fitHeight),
                ),
              );
            },
          ),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
