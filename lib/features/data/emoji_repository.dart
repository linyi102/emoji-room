import 'dart:io';

import 'package:emoji_room/features/domain/emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'emoji_repository.g.dart';

class EmojiRepository {
  String get dirPath => r'D:\Syfolder\图片\表情包';

  Future<List<Emoji>> fetchEmojis() async {
    List<Emoji> emojis = [];

    final fileStream = Directory(dirPath).list();
    await for (final fee in fileStream) {
      if ((await fee.stat()).type == FileSystemEntityType.file) {
        final fileEmoji = Emoji.fromFile(File(fee.path));
        final emoji = await mergeEmoji(fileEmoji);
        emojis.add(emoji);
      }
    }
    return emojis;
  }

  Future<Emoji> mergeEmoji(Emoji fileEmoji) async {
    File recordFile =
        File(p.join(dirPath, '.emojiroom', fileEmoji.size.toString()));
    if (!await recordFile.exists()) return fileEmoji;

    final configEmoji = Emoji.fromJson(await recordFile.readAsString());
    return configEmoji.copyWith(
      file: fileEmoji.file,
    );
  }
}

@riverpod
EmojiRepository emojiRepository(Ref ref) {
  return EmojiRepository();
}
