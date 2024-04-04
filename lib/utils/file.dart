import 'package:path/path.dart' as p;

class FileUtil {
  static isImage(String fileName) {
    return ['.jpg', '.png', '.webp'].contains(p.extension(fileName));
  }
}
