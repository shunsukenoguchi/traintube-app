import 'package:flutter/foundation.dart';

@immutable
class Todo {
  const Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.videoId = '',
  });

  final String id;
  final String title;
  final bool isCompleted;
  final String videoId;

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? videoId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      videoId: videoId ?? this.videoId,
    );
  }
}
