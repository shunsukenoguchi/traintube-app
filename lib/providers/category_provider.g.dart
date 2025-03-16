// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categorysHash() => r'34cd2603e6420d299794896506c123f7e0386fd6';

/// See also [Categorys].
@ProviderFor(Categorys)
final categorysProvider =
    AutoDisposeNotifierProvider<Categorys, List<Category>>.internal(
      Categorys.new,
      name: r'categorysProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$categorysHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Categorys = AutoDisposeNotifier<List<Category>>;
String _$selectedCategoryHash() => r'848078705738a1fa57cce270457e50676c58fc93';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, String?>.internal(
      SelectedCategory.new,
      name: r'selectedCategoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedCategory = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
