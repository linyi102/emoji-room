import 'dart:io';

import 'package:emoji_room/features/emoji_dir/providers/emoji_dir.dart';
import 'package:emoji_room/features/emoji_grid/domain/emoji.dart';
import 'package:emoji_room/features/emoji_tags/domain/emoji_tag.dart';
import 'package:emoji_room/utils/file.dart';
import 'package:emoji_room/utils/log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'emoji_repository.g.dart';

class EmojiRepository {
  final String mainDirPath;
  EmojiRepository({required this.mainDirPath});

  List<Emoji> cachedEmojis = [];
  List<EmojiTag> cachedEmojiTags = [];
  bool hasCached = false;

  Future<List<Emoji>> fetchEmojis({
    bool cache = true,
    bool scanQQ = false,
    List<String> keywords = const [],
  }) async {
    if (hasCached && cache) {
      return [...filterEmoji(cachedEmojis, keywords)];
    }

    const qqDirPath = '/storage/emulated/0/tencent/QQ_Favorite/';
    List<Emoji> emojis = [
      ...await _fetchDirEmojis(mainDirPath)
        ..forEach((e) => e.tags.add('主目录')),
      if (scanQQ)
        ...(await _fetchDirEmojis(qqDirPath, mustBeImageSuffix: false))
          ..forEach((e) => e.tags.add('QQ'))
    ];
    emojis.sort((a, b) => -a.fmTime.compareTo(b.fmTime));

    cachedEmojis = [...emojis];
    cachedEmojiTags = _collectEmojiTags(emojis);
    hasCached = true;

    return filterEmoji(emojis, keywords);
  }

  List<EmojiTag> fetchEmojiTags() {
    return [...cachedEmojiTags];
  }

  Future<bool> saveEmoji(Emoji newEmoji) async {
    if (!await _existDir(mainDirPath)) return false;

    final index = cachedEmojis.indexWhere((e) => e.id == newEmoji.id);
    cachedEmojis[index] = newEmoji;

    File recordFile = _getEmojiRecordFile(newEmoji);
    try {
      if (!await recordFile.exists()) await recordFile.create(recursive: true);
      await recordFile.writeAsString(newEmoji.toJson());
      return true;
    } catch (err) {
      Log.e(err);
      return false;
    }
  }

  List<Emoji> filterEmoji(List<Emoji> emojis, List<String> keywords) {
    if (keywords.isEmpty) return emojis;

    return emojis.where((emoji) {
      // 该表情的标题是否有关键字
      // 示例：搜索"a bc"时，查看是否有a并且有bc文本
      for (final keyword in keywords) {
        final tagHit = emoji.tags.contains(keyword);
        final titleHit =
            emoji.title.toLowerCase().contains(keyword.toLowerCase());
        if (!tagHit || !titleHit) return false;
      }
      return true;
    }).toList();
  }

  List<EmojiTag> _collectEmojiTags(List<Emoji> emojis) {
    List<EmojiTag> emojiTags = [];
    Map<String, int> tagCnt = {};

    for (final emoji in emojis) {
      for (final tag in emoji.tags) {
        tagCnt[tag] = (tagCnt[tag] ?? 0) + 1;
      }
    }
    for (final tagName in tagCnt.keys) {
      emojiTags.add(EmojiTag(name: tagName, count: tagCnt[tagName] ?? 0));
    }
    emojiTags.sort((a, b) => -a.count.compareTo(b.count));
    return emojiTags;
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
    return recordEmoji.copyWith(
      file: emoji.file,
      fcTime: emoji.fcTime,
      fmTime: emoji.fmTime,
    );
  }

  File _getEmojiRecordFile(Emoji emoji) {
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
