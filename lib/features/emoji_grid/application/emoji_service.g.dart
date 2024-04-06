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
String _$filteredEmojiListHash() => r'1138ddbd9c6a8b1e35e395919e5c0718a9f56d1c';

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
String _$emojiListHash() => r'633f6f88b2b6a3534e8387ff03f7a663ce280832';

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
