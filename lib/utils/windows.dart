import 'dart:io';

class WindowsUtil {
  static Future<bool> openFileExplorer(String? path) async {
    try {
      await Process.run('start', [path ?? '.'], runInShell: true);
      return true;
    } catch (e) {
      return false;
    }
  }
}
