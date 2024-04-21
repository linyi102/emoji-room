import 'package:emoji_room/features/emoji_grid/domain/inode.dart';

class FileInode extends Inode {
  FileInode({required super.name}) {
    super.type = InodeType.file;
  }
}
