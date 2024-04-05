// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_emoji.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentEmojiHash() => r'c98a9fb7bde916b294f30f405ef4978c0f664ab8';

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

/// See also [currentEmoji].
@ProviderFor(currentEmoji)
const currentEmojiProvider = CurrentEmojiFamily();

/// See also [currentEmoji].
class CurrentEmojiFamily extends Family<Emoji> {
  /// See also [currentEmoji].
  const CurrentEmojiFamily();

  /// See also [currentEmoji].
  CurrentEmojiProvider call(
    String id,
  ) {
    return CurrentEmojiProvider(
      id,
    );
  }

  @override
  CurrentEmojiProvider getProviderOverride(
    covariant CurrentEmojiProvider provider,
  ) {
    return call(
      provider.id,
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

/// See also [currentEmoji].
class CurrentEmojiProvider extends AutoDisposeProvider<Emoji> {
  /// See also [currentEmoji].
  CurrentEmojiProvider(
    String id,
  ) : this._internal(
          (ref) => currentEmoji(
            ref as CurrentEmojiRef,
            id,
          ),
          from: currentEmojiProvider,
          name: r'currentEmojiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentEmojiHash,
          dependencies: CurrentEmojiFamily._dependencies,
          allTransitiveDependencies:
              CurrentEmojiFamily._allTransitiveDependencies,
          id: id,
        );

  CurrentEmojiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Emoji Function(CurrentEmojiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentEmojiProvider._internal(
        (ref) => create(ref as CurrentEmojiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Emoji> createElement() {
    return _CurrentEmojiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentEmojiProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentEmojiRef on AutoDisposeProviderRef<Emoji> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CurrentEmojiProviderElement extends AutoDisposeProviderElement<Emoji>
    with CurrentEmojiRef {
  _CurrentEmojiProviderElement(super.provider);

  @override
  String get id => (origin as CurrentEmojiProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
