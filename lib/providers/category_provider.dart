import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';

part 'category_provider.g.dart';

@riverpod
class Categorys extends _$Categorys {
  @override
  List<Category> build() {
    return [
      Category(
        id: const Uuid().v4(),
        name: '全て',
        description: 'すべてのワークアウト',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  void add(String name, String description) {
    final now = DateTime.now();
    final newCategory = Category(
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
    state = [state[0], ...state.sublist(1), newCategory];
  }

  void update(String id, String name, String description) {
    state = [
      for (final category in state)
        if (category.id == id)
          category.copyWith(
            name: name,
            description: description,
            updatedAt: DateTime.now(),
          )
        else
          category,
    ];
  }

  void remove(String id) {
    state = state.where((category) => category.id != id).toList();
  }
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String? build() {
    return null;
  }

  void select(String? categoryId) {
    state = categoryId;
  }
}
