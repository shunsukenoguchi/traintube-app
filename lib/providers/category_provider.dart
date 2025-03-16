import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../repositories/category_repository.dart';
import '../db/database_helper.dart';

part 'category_provider.g.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(DatabaseHelper.instance);
});

@Riverpod(keepAlive: true)
class Categorys extends _$Categorys {
  @override
  Future<List<Category>> build() async {
    final repository = ref.watch(categoryRepositoryProvider);
    final categories = await repository.getAll();

    if (categories.isEmpty) {
      final now = DateTime.now();
      final defaultCategory = Category(
        name: '全て',
        description: 'すべてのカテゴリー',
        sortOrder: 0,
        createdAt: now,
        updatedAt: now,
      );
      await repository.insert(defaultCategory);
      return [defaultCategory];
    }

    return categories;
  }

  Future<void> add(String name, String description) async {
    final repository = ref.read(categoryRepositoryProvider);
    final maxSortOrder = await repository.getMaxSortOrder();

    final newCategory = Category(
      name: name,
      description: description,
      sortOrder: maxSortOrder + 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await repository.insert(newCategory);
    ref.invalidateSelf();
  }

  Future<void> updateCategory(
    String id, {
    String? name,
    String? description,
    int? sortOrder,
  }) async {
    final repository = ref.read(categoryRepositoryProvider);
    final category = await repository.getById(id);

    if (category != null) {
      final updatedCategory = category.copyWith(
        name: name ?? category.name,
        description: description ?? category.description,
        sortOrder: sortOrder ?? category.sortOrder,
        updatedAt: DateTime.now(),
      );

      await repository.update(updatedCategory);
      state = AsyncValue.data(await build());
    }
  }

  Future<void> updateOrder(List<Category> newOrder) async {
    final repository = ref.read(categoryRepositoryProvider);
    await repository.reorderCategories(newOrder);
    state = AsyncValue.data(await build());
  }

  Future<void> remove(String id) async {
    final repository = ref.read(categoryRepositoryProvider);
    await repository.delete(id);
    state = AsyncValue.data(await build());
  }
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() {
    final categorysAsync = ref.watch(categorysProvider);
    return switch (categorysAsync) {
      AsyncData(:final value) => value.isNotEmpty ? value[0].id : '',
      _ => '',
    };
  }

  void select(String categoryId) {
    state = categoryId;
  }
}
