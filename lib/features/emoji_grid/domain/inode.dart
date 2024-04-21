abstract class Inode {
  final String name;
  late final InodeType type;

  Inode({required this.name});
}

enum InodeType {
  file,
  directory;
}
