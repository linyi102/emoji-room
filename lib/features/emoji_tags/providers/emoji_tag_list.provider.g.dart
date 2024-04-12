// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_tag_list.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emojiTagListHash() => r'20747b5056d9800beac03939d5a3fcdcaf493368';

/// See also [EmojiTagList].
@ProviderFor(EmojiTagList)
final emojiTagListProvider =
    AutoDisposeNotifierProvider<EmojiTagList, List<EmojiTag>>.internal(
  EmojiTagList.new,
  name: r'emojiTagListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiTagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmojiTagList = AutoDisposeNotifier<List<EmojiTag>>;
String _$selectedEmojiTagListHash() =>
    r'60543e69cf2d63e5294fd5a693905dc608a758c9';

/// See also [SelectedEmojiTagList].
@ProviderFor(SelectedEmojiTagList)
final selectedEmojiTagListProvider =
    NotifierProvider<SelectedEmojiTagList, List<EmojiTag>>.internal(
  SelectedEmojiTagList.new,
  name: r'selectedEmojiTagListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedEmojiTagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedEmojiTagList = Notifier<List<EmojiTag>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
