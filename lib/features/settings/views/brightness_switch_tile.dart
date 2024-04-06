import 'package:emoji_room/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrightnessSwitchTile extends ConsumerWidget {
  const BrightnessSwitchTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(themeBrightnessProvider);
    final isDark = brightness == Brightness.dark;

    return SwitchListTile(
      title: const Text('夜间模式'),
      secondary:
          isDark ? const Icon(Icons.brightness_2) : const Icon(Icons.wb_sunny),
      value: isDark,
      onChanged: (value) => ref.read(themeBrightnessProvider.notifier).toggle(),
    );
  }
}
