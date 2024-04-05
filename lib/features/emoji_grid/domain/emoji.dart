import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class Emoji {
  final String id;
  final File file;
  final String fileName;
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
    required this.size,
    required this.title,
    required this.usageCount,
    required this.ignore,
    required this.cTime,
    required this.mTime,
  }) {
    tags = title.isNotEmpty ? title.split(RegExp(r'\s+')) : [];
  }

  factory Emoji.fromFile(File file) {
    final now = DateTime.now();
    final size = file.statSync().size;

    return Emoji(
      id: p.basenameWithoutExtension(file.path),
      file: file,
      fileName: p.basename(file.path),
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
      id: map['id'] as String,
      file: File(''),
      fileName: map['fileName'] as String,
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
    return 'Emoji(file: $file, fileName: $fileName, size: $size, title: $title, usageCount: $usageCount, ignore: $ignore, cTime: $cTime, mTime: $mTime)';
  }

  @override
  bool operator ==(covariant Emoji other) {
    if (identical(this, other)) return true;

    return other.file == file &&
        other.fileName == fileName &&
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
        size.hashCode ^
        title.hashCode ^
        usageCount.hashCode ^
        ignore.hashCode ^
        cTime.hashCode ^
        mTime.hashCode;
  }
}
