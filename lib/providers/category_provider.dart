import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';

part 'category_provider.g.dart';

@riverpod
class Categorys extends _$Categorys {
  @override
  List<Category> build() {
    final now = DateTime.now();
    return [
      Category(
        name: '全て',
        description: 'すべてのカテゴリー',
        index: 0,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  void add(String name, String description) {
    final newCategory = Category(
      name: name,
      description: description,
      index: state.length,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = [state[0], ...state.sublist(1), newCategory];
  }

  void update(String id, {String? name, String? description, int? index}) {
    state = [
      for (final category in state)
        if (category.id == id)
          category.copyWith(
            name: name ?? category.name,
            description: description ?? category.description,
            index: index ?? category.index,
            updatedAt: DateTime.now(),
          )
        else
          category,
    ];
  }

  void updateOrder(List<Category> newOrder) {
    state = [
      for (var i = 0; i < newOrder.length; i++)
        newOrder[i].copyWith(index: i),
    ];
  }

  void remove(String id) {
    final newState = state.where((category) => category.id != id).toList();
    // 削除後にインデックスを振り直す
    state = [
      for (var i = 0; i < newState.length; i++)
        newState[i].copyWith(index: i),
    ];
  }
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() {
    final categorys = ref.watch(categorysProvider);
    return categorys.isNotEmpty ? categorys[0].id : '';
  }

  void select(String categoryId) {
    state = categoryId;
  }
}
