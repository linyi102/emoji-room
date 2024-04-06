import 'package:emoji_room/features/emoji_dir/providers/scan_qq.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanQQTile extends ConsumerWidget {
  const ScanQQTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scan = ref.watch(scanQQProvider);
    return SwitchListTile(
      title: const Text('扫描 QQ 表情目录'),
      secondary: const Icon(Icons.find_in_page_rounded),
      value: scan,
      onChanged: (value) => ref.read(scanQQProvider.notifier).toggle(),
    );
  }
}
