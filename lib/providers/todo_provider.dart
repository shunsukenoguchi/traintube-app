import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/todo.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().toIso8601String(),
      title: title,
    );
    state = [...state, todo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
