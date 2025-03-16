import 'package:uuid/uuid.dart';

class Category {
  Category({
    String? id,
    required this.name,
    required this.description,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final String description;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category copyWith({
    String? name,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
