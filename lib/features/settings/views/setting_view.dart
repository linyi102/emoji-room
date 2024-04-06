import 'package:emoji_room/features/emoji_dir/views/emoji_dir_tile.dart';
import 'package:emoji_room/features/emoji_dir/views/scan_qq_tile.dart';
import 'package:emoji_room/features/settings/views/brightness_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            EmojiDirTile(),
            BrightnessSwitchTile(),
            ScanQQTile(),
          ],
        ),
      ),
    );
  }
}
