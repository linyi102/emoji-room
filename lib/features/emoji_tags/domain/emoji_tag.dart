import 'dart:convert';

class EmojiTag {
  final String name;
  final int count;
  final bool isSelected;
  EmojiTag({
    required this.name,
    required this.count,
    this.isSelected = false,
  });

  EmojiTag copyWith({
    String? name,
    int? count,
    bool? isSelected,
  }) {
    return EmojiTag(
      name: name ?? this.name,
      count: count ?? this.count,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'count': count,
      'isSelected': isSelected,
    };
  }

  factory EmojiTag.fromMap(Map<String, dynamic> map) {
    return EmojiTag(
      name: map['name'] as String,
      count: map['count'] as int,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmojiTag.fromJson(String source) =>
      EmojiTag.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EmojiTag(name: $name, count: $count, isSelected: $isSelected)';

  @override
  bool operator ==(covariant EmojiTag other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.count == count &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ count.hashCode ^ isSelected.hashCode;
}
