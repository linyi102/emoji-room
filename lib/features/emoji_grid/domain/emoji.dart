import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class Emoji {
  File file;
  String filePath;
  int size;
  String title;
  int usageCount;
  bool ignore;
  DateTime cTime;
  DateTime mTime;

  Emoji({
    required this.file,
    required this.filePath,
    required this.size,
    required this.title,
    required this.usageCount,
    required this.ignore,
    required this.cTime,
    required this.mTime,
  });

  factory Emoji.fromFile(File file) {
    final now = DateTime.now();
    return Emoji(
      file: file,
      filePath: p.basename(file.path),
      size: file.statSync().size,
      title: '',
      usageCount: 0,
      ignore: false,
      cTime: now,
      mTime: now,
    );
  }

  Emoji copyWith({
    File? file,
    String? filePath,
    int? size,
    String? title,
    int? usageCount,
    bool? ignore,
    DateTime? cTime,
    DateTime? mTime,
  }) {
    return Emoji(
      file: file ?? this.file,
      filePath: filePath ?? this.filePath,
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
      'filePath': filePath,
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
      file: File(''),
      filePath: map['filePath'] as String,
      size: map['size'] as int,
      title: map['title'] as String,
      usageCount: map['usageCount'] as int,
      ignore: map['ignore'] as bool,
      cTime: DateTime.fromMillisecondsSinceEpoch(map['cTime'] as int),
      mTime: DateTime.fromMillisecondsSinceEpoch(map['mTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Emoji.fromJson(String source) =>
      Emoji.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Emoji(file: $file, filePath: $filePath, size: $size, title: $title, usageCount: $usageCount, ignore: $ignore, cTime: $cTime, mTime: $mTime)';
  }

  @override
  bool operator ==(covariant Emoji other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.filePath == filePath &&
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
        filePath.hashCode ^
        size.hashCode ^
        title.hashCode ^
        usageCount.hashCode ^
        ignore.hashCode ^
        cTime.hashCode ^
        mTime.hashCode;
  }
}
