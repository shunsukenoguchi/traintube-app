import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/todo_provider.dart';
import 'youtube_player_screen.dart';

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final titleController = useTextEditingController();
    final videoIdController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
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
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing:
                  todo.videoId.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.play_circle_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => YoutubePlayerScreen(
                                    url:
                                        'https://www.youtube.com/watch?v=${"3XEdhurz9fw"}',
                                  ),
                            ),
                          );
                        },
                      )
                      : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('新しいタスク'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'タスクを入力してください',
                          labelText: 'タスク名',
                        ),
                        autofocus: true,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: videoIdController,
                        decoration: const InputDecoration(
                          hintText: 'YouTube動画IDを入力（任意）',
                          labelText: 'YouTube動画ID',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          ref
                              .read(todoListProvider.notifier)
                              .addTodo(
                                titleController.text,
                                videoId: videoIdController.text,
                              );
                          titleController.clear();
                          videoIdController.clear();
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
