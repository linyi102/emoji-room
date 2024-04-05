import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class Emoji {
  final String id;

  final File file;
  final String fileName;
  final DateTime fcTime;
  final DateTime fmTime;
  final int size;

  final String title;
  final int usageCount;
  final bool ignore;
  final DateTime cTime;
  final DateTime mTime;
  late final List<String> tags;

  Emoji({
    required this.id,
    required this.file,
    required this.fileName,
    required this.fcTime,
    required this.fmTime,
    required this.size,
    required this.title,
    required this.usageCount,
    required this.ignore,
    required this.cTime,
    required this.mTime,
  }) {
    tags = title.isNotEmpty ? title.split(RegExp(r'\s+')) : [];
  }

  factory Emoji.fromFile(File file, FileStat stat) {
    final now = DateTime.now();
    final size = stat.size;

    return Emoji(
      id: p.basenameWithoutExtension(file.path),
      file: file,
      fileName: p.basename(file.path),
      fcTime: stat.changed,
      fmTime: stat.modified,
      size: size,
      title: '',
      usageCount: 0,
      ignore: false,
      cTime: now,
      mTime: now,
    );
  }

  static const String _invaidId = 'invalid';
  bool get isInvalid => id == _invaidId;

  factory Emoji.invalid() {
    return Emoji(
      id: _invaidId,
      file: File(''),
      fileName: '',
      fcTime: DateTime(0),
      fmTime: DateTime(0),
      size: 0,
      title: '',
      usageCount: 0,
      ignore: false,
      cTime: DateTime(0),
      mTime: DateTime(0),
    );
  }

  Emoji copyWith({
    String? id,
    File? file,
    String? fileName,
    DateTime? fcTime,
    DateTime? fmTime,
    int? size,
    String? title,
    int? usageCount,
    bool? ignore,
    DateTime? cTime,
    DateTime? mTime,
  }) {
    return Emoji(
      id: id ?? this.id,
      file: file ?? this.file,
      fileName: fileName ?? this.fileName,
      fcTime: fcTime ?? this.fcTime,
      fmTime: fmTime ?? this.fmTime,
      size: size ?? this.size,
      title: title ?? this.title,
      usageCount: usageCount ?? this.usageCount,
      ignore: ignore ?? this.ignore,
      cTime: cTime ?? this.cTime,
      mTime: mTime ?? this.mTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fileName': fileName,
      'fcTime': fcTime.millisecondsSinceEpoch,
      'fmTime': fmTime.millisecondsSinceEpoch,
      'size': size,
      'title': title,
      'usageCount': usageCount,
      'ignore': ignore,
      'cTime': cTime.millisecondsSinceEpoch,
      'mTime': mTime.millisecondsSinceEpoch,
    };
  }

  factory Emoji.fromMap(Map<String, dynamic> map) {
    return Emoji(
      id: map['id'] as String? ?? _invaidId,
      file: File(''),
      fileName: map['fileName'] as String? ?? '',
      fcTime: DateTime.fromMillisecondsSinceEpoch(map['fcTime'] as int? ?? 0),
      fmTime: DateTime.fromMillisecondsSinceEpoch(map['fmTime'] as int? ?? 0),
      size: map['size'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      usageCount: map['usageCount'] as int? ?? 0,
      ignore: map['ignore'] as bool? ?? false,
      cTime: DateTime.fromMillisecondsSinceEpoch(map['cTime'] as int? ?? 0),
      mTime: DateTime.fromMillisecondsSinceEpoch(map['mTime'] as int? ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory Emoji.fromJson(String source) =>
      Emoji.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Emoji(file: $file, fileName: $fileName, fcTime: $fcTime, fmTime: $fmTime size: $size, title: $title, usageCount: $usageCount, ignore: $ignore, cTime: $cTime, mTime: $mTime)';
  }

  @override
  bool operator ==(covariant Emoji other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.fileName == fileName &&
        other.fcTime == fcTime &&
        other.fmTime == fmTime &&
        other.size == size &&
        other.title == title &&
        other.usageCount == usageCount &&
        other.ignore == ignore &&
        other.cTime == cTime &&
        other.mTime == mTime;
  }

  @override
  int get hashCode {
    return file.hashCode ^
        fileName.hashCode ^
        fcTime.hashCode ^
        fmTime.hashCode ^
        size.hashCode ^
        title.hashCode ^
        usageCount.hashCode ^
        ignore.hashCode ^
        cTime.hashCode ^
        mTime.hashCode;
  }
}
