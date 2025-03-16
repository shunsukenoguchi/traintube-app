// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categorysHash() => r'da697157936fdbfa19e2f7804536b26430d4603b';

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
String _$selectedCategoryHash() => r'ea52a975a0aecff96fc7d5d28839e634e3233bd9';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, String>.internal(
      SelectedCategory.new,
      name: r'selectedCategoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedCategory = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
