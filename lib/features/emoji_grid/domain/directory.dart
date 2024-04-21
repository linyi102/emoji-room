import 'package:emoji_room/features/emoji_grid/domain/inode.dart';

class DirectoryInode extends Inode {
  DirectoryInode({required super.name}) {
    super.type = InodeType.directory;
  }
}
