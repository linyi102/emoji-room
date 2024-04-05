import 'dart:io';

import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/utils/file.dart';
import 'package:emoji_room/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'emoji_repository.g.dart';

class EmojiRepository {
  final String dirPath;
  EmojiRepository({required this.dirPath});

  Future<List<Emoji>> fetchEmojis() async {
    if (!await _existDir()) return [];

    List<Emoji> emojis = [];
    final fileStream = Directory(dirPath).list();
    await for (final fse in fileStream) {
      final stat = await fse.stat();
      bool isFile = stat.type == FileSystemEntityType.file;
      bool isImage = FileUtil.isImage(fse.path);

      if (isFile && isImage) {
        final fileEmoji = Emoji.fromFile(File(fse.path));
        final emoji = await mergeEmoji(fileEmoji);
        emojis.add(emoji);
      }
    }
    emojis.sort((a, b) =>
        -a.file.statSync().modified.compareTo(b.file.statSync().modified));
    return emojis;
  }

  Future<Emoji> mergeEmoji(Emoji emoji) async {
    File recordFile = _getEmojiRecordFile(emoji);
    if (!await recordFile.exists()) return emoji;

    late String json;
    try {
      json = await recordFile.readAsString();
    } catch (e) {
      return emoji;
    }
    final recordEmoji = Emoji.fromJson(json);
    return recordEmoji.copyWith(file: emoji.file);
  }

  Future<bool> saveEmoji(Emoji emoji) async {
    if (!await _existDir()) return false;

    File recordFile = _getEmojiRecordFile(emoji);
    try {
      if (!await recordFile.exists()) await recordFile.create(recursive: true);
      await recordFile.writeAsString(emoji.toJson());
      return true;
    } catch (err) {
      Log.e(err);
      return false;
    }
  }

  _getEmojiRecordFile(Emoji emoji) {
    return File(p.join(dirPath, '.emojiroom', emoji.id));
  }

  Future<bool> _existDir() async {
    final dir = Directory(dirPath);
    return dir.exists();
  }
}

@Riverpod(keepAlive: true)
EmojiRepository emojiRepository(Ref ref) {
  final dirPath = ref.watch(emojiDirPathProvider);
  return EmojiRepository(dirPath: dirPath ?? '');
}
