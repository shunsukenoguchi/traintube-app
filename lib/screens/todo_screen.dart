import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/todo_provider.dart';

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return Dismissible(
            key: Key(todo.id),
            onDismissed: (_) {
              ref.read(todoListProvider.notifier).removeTodo(todo.id);
            },
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) {
                  ref.read(todoListProvider.notifier).toggleTodo(todo.id);
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('新しいタスク'),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'タスクを入力してください',
                ),
                autofocus: true,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      ref
                          .read(todoListProvider.notifier)
                          .addTodo(textController.text);
                      textController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('追加'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
