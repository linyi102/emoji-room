import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:emoji_room/constants/assets.gen.dart';
import 'package:emoji_room/constants/strings.dart';
import 'package:emoji_room/features/home/views/home.dart';
import 'package:emoji_room/providers/config.dart';
import 'package:emoji_room/providers/theme.dart';
import 'package:emoji_room/utils/keyboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await prepareWindow();

  Hive.init((await getApplicationDocumentsDirectory()).path);
  final config = await loadConfig();

  runApp(ProviderScope(overrides: [
    configProvider.overrideWithValue(config),
  ], child: const MyApp()));
}

Future<void> prepareWindow() async {
  if (!Platform.isWindows) return;

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1080, 720),
      minimumSize: Size(300, 600),
      center: true,
      titleBarStyle: TitleBarStyle.hidden,
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );
}

Future<Config> loadConfig() async {
  final config = Config();
  await config.init();
  return config;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final botToastBuilder = BotToastInit();
    final brightness = ref.watch(themeBrightnessProvider);

    return MaterialApp(
      title: kAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: brightness,
        ),
        useMaterial3: true,
        fontFamilyFallback: const ['HarmonyOS Sans SC', 'Microsoft YaHei'],
        appBarTheme: Platform.isWindows
            ? const AppBarTheme(scrolledUnderElevation: 0)
            : null,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = botToastBuilder(context, child);
        child = Scaffold(
          // 顶层的resizeToAvoidBottomInset也要置为false
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => KeyBoardControl.cancelKeyBoard(context),
            child: child,
          ),
        );
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: Column(
        children: [
          if (Platform.isWindows) _buildWindowCaption(),
          const Expanded(child: HomePage())
        ],
      ),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }

  SizedBox _buildWindowCaption() {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Assets.logo.image(height: 24, width: 24),
                ),
                const Text(kAppName),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: StatefulBuilder(
              builder: (context, setState) => WindowCaption(
                brightness: Theme.of(context).brightness,
                backgroundColor: Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// support mouse drag
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
