// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_tag_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedEmojiTagListHash() =>
    r'd5db65a86dfd8a08f845096d650957c6b99cbed4';

/// See also [selectedEmojiTagList].
@ProviderFor(selectedEmojiTagList)
final selectedEmojiTagListProvider = Provider<List<EmojiTag>>.internal(
  selectedEmojiTagList,
  name: r'selectedEmojiTagListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedEmojiTagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedEmojiTagListRef = ProviderRef<List<EmojiTag>>;
String _$emojiTagListHash() => r'77840a9e0bfa29648a7d53980fae4568a592bcf7';

/// See also [EmojiTagList].
@ProviderFor(EmojiTagList)
final emojiTagListProvider =
    NotifierProvider<EmojiTagList, List<EmojiTag>>.internal(
  EmojiTagList.new,
  name: r'emojiTagListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiTagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmojiTagList = Notifier<List<EmojiTag>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
