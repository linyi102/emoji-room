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
String _$searchKeywordsHash() => r'dbc44e886a11767d3244c671ed1d8620ad4d5fd6';

/// See also [searchKeywords].
@ProviderFor(searchKeywords)
final searchKeywordsProvider = Provider<List<String>>.internal(
  searchKeywords,
  name: r'searchKeywordsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchKeywordsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchKeywordsRef = ProviderRef<List<String>>;
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
String _$emojiListHash() => r'17bc1f0767db5162257405f53b907a9461ff48ca';

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
