import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
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

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    title: kAppName,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
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
        fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
      ),
      builder: (context, child) {
        child = botToastBuilder(context, child);
        child = MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            // 顶层的resizeToAvoidBottomInset也要置为false
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () => KeyBoardControl.cancelKeyBoard(context),
              child: child,
            ),
          ),
        );
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
      scrollBehavior: MyCustomScrollBehavior(),
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
