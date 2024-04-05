import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_search.provider.g.dart';

@Riverpod(keepAlive: true)
class EmojiSearchKeyword extends _$EmojiSearchKeyword {
  late final TextEditingController keywordTec;

  @override
  String build() {
    keywordTec = TextEditingController();
    ref.onDispose(() {
      keywordTec.dispose();
    });
    return '';
  }

  updateKeyword(String keyword) {
    state = keyword;
  }

  clearKeyword() {
    keywordTec.clear();
    state = '';
  }
}
