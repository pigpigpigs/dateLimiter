// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$insertPageViewModelHash() =>
    r'75f4445b2268c55117405ebe684c4dbd4dfcd736';

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

abstract class _$InsertPageViewModel
    extends BuildlessAutoDisposeAsyncNotifier<InsertItem> {
  late final String imagePath;

  FutureOr<InsertItem> build(String imagePath);
}

/// See also [InsertPageViewModel].
@ProviderFor(InsertPageViewModel)
const insertPageViewModelProvider = InsertPageViewModelFamily();

/// See also [InsertPageViewModel].
class InsertPageViewModelFamily extends Family<AsyncValue<InsertItem>> {
  /// See also [InsertPageViewModel].
  const InsertPageViewModelFamily();

  /// See also [InsertPageViewModel].
  InsertPageViewModelProvider call(String imagePath) {
    return InsertPageViewModelProvider(imagePath);
  }

  @override
  InsertPageViewModelProvider getProviderOverride(
    covariant InsertPageViewModelProvider provider,
  ) {
    return call(provider.imagePath);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'insertPageViewModelProvider';
}

/// See also [InsertPageViewModel].
class InsertPageViewModelProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<InsertPageViewModel, InsertItem> {
  /// See also [InsertPageViewModel].
  InsertPageViewModelProvider(String imagePath)
    : this._internal(
        () => InsertPageViewModel()..imagePath = imagePath,
        from: insertPageViewModelProvider,
        name: r'insertPageViewModelProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$insertPageViewModelHash,
        dependencies: InsertPageViewModelFamily._dependencies,
        allTransitiveDependencies:
            InsertPageViewModelFamily._allTransitiveDependencies,
        imagePath: imagePath,
      );

  InsertPageViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.imagePath,
  }) : super.internal();

  final String imagePath;

  @override
  FutureOr<InsertItem> runNotifierBuild(
    covariant InsertPageViewModel notifier,
  ) {
    return notifier.build(imagePath);
  }

  @override
  Override overrideWith(InsertPageViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: InsertPageViewModelProvider._internal(
        () => create()..imagePath = imagePath,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        imagePath: imagePath,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<InsertPageViewModel, InsertItem>
  createElement() {
    return _InsertPageViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InsertPageViewModelProvider && other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, imagePath.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InsertPageViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<InsertItem> {
  /// The parameter `imagePath` of this provider.
  String get imagePath;
}

class _InsertPageViewModelProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<InsertPageViewModel, InsertItem>
    with InsertPageViewModelRef {
  _InsertPageViewModelProviderElement(super.provider);

  @override
  String get imagePath => (origin as InsertPageViewModelProvider).imagePath;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
