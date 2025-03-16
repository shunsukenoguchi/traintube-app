import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/category.dart';

class CategoryRepository {
  final DatabaseHelper _db;

  CategoryRepository(this._db);

  Future<void> insert(Category category) async {
    final db = await _db.database;
    await db.insert('categories', {
      'id': category.id,
      'name': category.name,
      'description': category.description,
      'sort_order': category.sortOrder,
      'created_at': category.createdAt.toIso8601String(),
      'updated_at': category.updatedAt.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Category>> getAll() async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      orderBy: 'sort_order ASC',
    );

    return maps
        .map(
          (map) => Category(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            sortOrder: map['sort_order'],
            createdAt: DateTime.parse(map['created_at']),
            updatedAt: DateTime.parse(map['updated_at']),
          ),
        )
        .toList();
  }

  Future<Category?> getById(String id) async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      sortOrder: map['sort_order'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Future<void> update(Category category) async {
    final db = await _db.database;
    await db.update(
      'categories',
      {
        'name': category.name,
        'description': category.description,
        'sort_order': category.sortOrder,
        'updated_at': category.updatedAt.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getMaxSortOrder() async {
    final db = await _db.database;
    final result = await db.rawQuery(
      'SELECT MAX(sort_order) as maxSortOrder FROM categories',
    );
    return (result.first['maxSortOrder'] as int?) ?? -1;
  }

  Future<void> reorderCategories(List<Category> categories) async {
    final db = await _db.database;
    await db.transaction((txn) async {
      for (var i = 0; i < categories.length; i++) {
        final category = categories[i];
        await txn.update(
          'categories',
          {'sort_order': i},
          where: 'id = ?',
          whereArgs: [category.id],
        );
      }
    });
  }
}
