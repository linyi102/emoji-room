// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_emoji.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentEmojiHash() => r'87db9b2fc47c09f6524929692a01e6a67d572c40';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CurrentEmoji extends BuildlessAutoDisposeNotifier<Emoji> {
  late final Emoji emoji;

  Emoji build(
    Emoji emoji,
  );
}

/// See also [CurrentEmoji].
@ProviderFor(CurrentEmoji)
const currentEmojiProvider = CurrentEmojiFamily();

/// See also [CurrentEmoji].
class CurrentEmojiFamily extends Family<Emoji> {
  /// See also [CurrentEmoji].
  const CurrentEmojiFamily();

  /// See also [CurrentEmoji].
  CurrentEmojiProvider call(
    Emoji emoji,
  ) {
    return CurrentEmojiProvider(
      emoji,
    );
  }

  @override
  CurrentEmojiProvider getProviderOverride(
    covariant CurrentEmojiProvider provider,
  ) {
    return call(
      provider.emoji,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentEmojiProvider';
}

/// See also [CurrentEmoji].
class CurrentEmojiProvider
    extends AutoDisposeNotifierProviderImpl<CurrentEmoji, Emoji> {
  /// See also [CurrentEmoji].
  CurrentEmojiProvider(
    Emoji emoji,
  ) : this._internal(
          () => CurrentEmoji()..emoji = emoji,
          from: currentEmojiProvider,
          name: r'currentEmojiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentEmojiHash,
          dependencies: CurrentEmojiFamily._dependencies,
          allTransitiveDependencies:
              CurrentEmojiFamily._allTransitiveDependencies,
          emoji: emoji,
        );

  CurrentEmojiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.emoji,
  }) : super.internal();

  final Emoji emoji;

  @override
  Emoji runNotifierBuild(
    covariant CurrentEmoji notifier,
  ) {
    return notifier.build(
      emoji,
    );
  }

  @override
  Override overrideWith(CurrentEmoji Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentEmojiProvider._internal(
        () => create()..emoji = emoji,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        emoji: emoji,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CurrentEmoji, Emoji> createElement() {
    return _CurrentEmojiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentEmojiProvider && other.emoji == emoji;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, emoji.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentEmojiRef on AutoDisposeNotifierProviderRef<Emoji> {
  /// The parameter `emoji` of this provider.
  Emoji get emoji;
}

class _CurrentEmojiProviderElement
    extends AutoDisposeNotifierProviderElement<CurrentEmoji, Emoji>
    with CurrentEmojiRef {
  _CurrentEmojiProviderElement(super.provider);

  @override
  Emoji get emoji => (origin as CurrentEmojiProvider).emoji;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
