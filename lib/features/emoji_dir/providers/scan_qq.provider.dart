import 'package:emoji_room/providers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_qq.provider.g.dart';

@Riverpod(keepAlive: true)
class ScanQQ extends _$ScanQQ {
  @override
  bool build() {
    final config = ref.watch(configProvider);
    return config.getScanQQ();
  }

  void toggle() {
    state = !state;
    ref.read(configProvider).setScanQQ(state);
  }
}
