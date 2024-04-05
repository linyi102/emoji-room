import 'package:emoji_room/providers/config.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@riverpod
class ThemeBrightness extends _$ThemeBrightness {
  @override
  Brightness build() {
    final config = ref.watch(configProvider);
    return config.getIsDark() ? Brightness.dark : Brightness.light;
  }

  void toggle() {
    state = state == Brightness.light ? Brightness.dark : Brightness.light;
    ref.read(configProvider).setIsDark(state == Brightness.dark);
  }
}
