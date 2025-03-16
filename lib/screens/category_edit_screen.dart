import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/category_provider.dart';

class CategoryEditScreen extends HookConsumerWidget {
  const CategoryEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categorysProvider);

    // インデックスでソートしたカテゴリーのリスト（「全て」は除外）
    final sortedCategories = [...categories.sublist(1)]
      ..sort((a, b) => a.index.compareTo(b.index));

    return Scaffold(
      appBar: AppBar(title: const Text('カテゴリー管理')),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          // 新しいインデックスの調整
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          // カテゴリーの並び替え
          final item = sortedCategories.removeAt(oldIndex);
          sortedCategories.insert(newIndex, item);

          // 並び替えの保存（「全て」を先頭に追加）
          ref.read(categorysProvider.notifier).updateOrder([
            categories[0],
            ...sortedCategories,
          ]);
        },
        children:
            sortedCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;

              return ReorderableDragStartListener(
                key: ValueKey(category.id),
                index: index,
                child: Card(
                  child: ListTile(
                    title: Text(category.name),
                    subtitle: Text(category.description),
                    leading: const Icon(Icons.drag_handle),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        final nameController = TextEditingController(
                          text: category.name,
                        );
                        final descController = TextEditingController(
                          text: category.description,
                        );

                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('カテゴリーを編集'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'カテゴリー名*',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: descController,
                                      decoration: const InputDecoration(
                                        labelText: '説明（任意）',
                                      ),
                                      maxLines: 3,
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
                                      if (nameController.text.isNotEmpty) {
                                        ref
                                            .read(categorysProvider.notifier)
                                            .update(
                                              category.id,
                                              name: nameController.text,
                                              description: descController.text,
                                            );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('更新'),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();
          final descriptionController = TextEditingController();
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('新規カテゴリー追加'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'カテゴリー名*'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(labelText: '説明（任意）'),
                        maxLines: 3,
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
                        if (nameController.text.isNotEmpty) {
                          ref
                              .read(categorysProvider.notifier)
                              .add(
                                nameController.text,
                                descriptionController.text,
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('追加'),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
