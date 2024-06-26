import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emoji_search.provider.g.dart';

class EmojiSearchState {
  final String keyword;
  final TextEditingController keywordTec;
  final FocusNode focusNode;
  final bool hasFocus;
  EmojiSearchState({
    this.keyword = '',
    required this.keywordTec,
    required this.focusNode,
    this.hasFocus = false,
  });

  void dispose() {
    keywordTec.dispose();
    focusNode.dispose();
  }

  EmojiSearchState copyWith({
    String? keyword,
    TextEditingController? keywordTec,
    FocusNode? focusNode,
    bool? hasFocus,
  }) {
    return EmojiSearchState(
      keyword: keyword ?? this.keyword,
      keywordTec: keywordTec ?? this.keywordTec,
      focusNode: focusNode ?? this.focusNode,
      hasFocus: hasFocus ?? this.hasFocus,
    );
  }

  @override
  bool operator ==(covariant EmojiSearchState other) {
    if (identical(this, other)) return true;

    return other.keyword == keyword &&
        other.keywordTec == keywordTec &&
        other.focusNode == focusNode &&
        other.hasFocus == hasFocus;
  }

  @override
  int get hashCode {
    return keyword.hashCode ^
        keywordTec.hashCode ^
        focusNode.hashCode ^
        hasFocus.hashCode;
  }
}

@Riverpod(keepAlive: true)
class EmojiSearchController extends _$EmojiSearchController {
  @override
  EmojiSearchState build() {
    final model = EmojiSearchState(
        keywordTec: TextEditingController(), focusNode: FocusNode());
    ref.onDispose(() {
      model.focusNode.removeListener(focusNodeListener);
      model.dispose();
    });
    model.focusNode.addListener(focusNodeListener);
    return model;
  }

  void focusNodeListener() {
    if (state.hasFocus != state.focusNode.hasFocus) {
      state = state.copyWith(hasFocus: state.focusNode.hasFocus);
    }
  }

  void updateKeyword(String value) {
    state = state.copyWith(keyword: value);
  }

  void clearKeyword() {
    state.keywordTec.clear();
    state = state.copyWith(keyword: '');
  }
}
