import 'dart:io';

import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/utils/file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'emoji_repository.g.dart';

class EmojiRepository {
  Future<List<Emoji>> fetchEmojis(String dirPath) async {
    List<Emoji> emojis = [];

    final fileStream = Directory(dirPath).list();
    await for (final fse in fileStream) {
      bool isFile = (await fse.stat()).type == FileSystemEntityType.file;
      bool isImage = FileUtil.isImage(fse.path);

      if (isFile && isImage) {
        final fileEmoji = Emoji.fromFile(File(fse.path));
        final emoji = await mergeEmoji(dirPath, fileEmoji);
        emojis.add(emoji);
      }
    }
    return emojis;
  }

  Future<Emoji> mergeEmoji(String dirPath, Emoji fileEmoji) async {
    File recordFile =
        File(p.join(dirPath, '.emojiroom', fileEmoji.size.toString()));
    if (!await recordFile.exists()) return fileEmoji;

    final configEmoji = Emoji.fromJson(await recordFile.readAsString());
    return configEmoji.copyWith(
      file: fileEmoji.file,
    );
  }
}

@Riverpod(keepAlive: true)
EmojiRepository emojiRepository(Ref ref) {
  return EmojiRepository();
}
