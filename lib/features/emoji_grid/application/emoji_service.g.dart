// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emojiServiceHash() => r'f05080c7f68b270a704119894f369b1f75f75cb7';

/// See also [emojiService].
@ProviderFor(emojiService)
final emojiServiceProvider = Provider<EmojiService>.internal(
  emojiService,
  name: r'emojiServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmojiServiceRef = ProviderRef<EmojiService>;
String _$filteredEmojiListHash() => r'7ec88c4177993ce3920975f04d5b352ca5dba6d4';

/// See also [filteredEmojiList].
@ProviderFor(filteredEmojiList)
final filteredEmojiListProvider =
    AutoDisposeFutureProvider<List<Emoji>>.internal(
  filteredEmojiList,
  name: r'filteredEmojiListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredEmojiListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredEmojiListRef = AutoDisposeFutureProviderRef<List<Emoji>>;
String _$emojiTotalHash() => r'7cd3c0777017076c09071eabfb376a847fd69ca8';

/// See also [emojiTotal].
@ProviderFor(emojiTotal)
final emojiTotalProvider = AutoDisposeProvider<int>.internal(
  emojiTotal,
  name: r'emojiTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmojiTotalRef = AutoDisposeProviderRef<int>;
String _$emojiListHash() => r'44fae32a224e979c79c8a81b9270861881112994';

/// See also [EmojiList].
@ProviderFor(EmojiList)
final emojiListProvider =
    AsyncNotifierProvider<EmojiList, List<Emoji>>.internal(
  EmojiList.new,
  name: r'emojiListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmojiList = AsyncNotifier<List<Emoji>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
