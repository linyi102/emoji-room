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
  final String mainDirPath;
  EmojiRepository({required this.mainDirPath});

  Future<List<Emoji>> fetchEmojis() async {
    const qqDirPath = '/storage/emulated/0/tencent/QQ_Favorite/';
    List<Emoji> emojis = [
      ...await _fetchDirEmojis(mainDirPath)
        ..forEach((e) => e.tags.add('主目录')),
      ...(await _fetchDirEmojis(qqDirPath, mustBeImageSuffix: false))
        ..forEach((e) => e.tags.add('QQ'))
    ];
    emojis.sort((a, b) => -a.fmTime.compareTo(b.fmTime));
    return emojis;
  }

  Future<List<Emoji>> _fetchDirEmojis(String dirPath,
      {bool mustBeImageSuffix = true}) async {
    if (!await _existDir(dirPath)) return [];

    List<Emoji> emojis = [];
    final fileStream = Directory(dirPath).list();
    await for (final fse in fileStream) {
      final stat = await fse.stat();
      bool isFile = stat.type == FileSystemEntityType.file;
      bool isImage = FileUtil.isImage(fse.path);

      if (isFile && (isImage || !mustBeImageSuffix)) {
        final fileEmoji = Emoji.fromFile(File(fse.path), stat);
        final emoji = await _mergeEmoji(fileEmoji);
        emojis.add(emoji);
      }
    }
    return emojis;
  }

  Future<Emoji> _mergeEmoji(Emoji emoji) async {
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
    if (!await _existDir(mainDirPath)) return false;

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
    return File(p.join(mainDirPath, '.emojiroom', emoji.id));
  }

  Future<bool> _existDir(String dirPath) async {
    final dir = Directory(dirPath);
    return dir.exists();
  }
}

@Riverpod(keepAlive: true)
EmojiRepository emojiRepository(Ref ref) {
  final dirPath = ref.watch(emojiDirPathProvider);
  return EmojiRepository(mainDirPath: dirPath ?? '');
}
