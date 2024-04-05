// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emojiServiceHash() => r'd9301abce6ee9015844678811b635e9f6169f396';

/// See also [emojiService].
@ProviderFor(emojiService)
final emojiServiceProvider = AutoDisposeProvider<EmojiService>.internal(
  emojiService,
  name: r'emojiServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emojiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EmojiServiceRef = AutoDisposeProviderRef<EmojiService>;
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
String _$emojiListHash() => r'b501284306e768395cb05b629bc11c65dbfa9ccd';

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
