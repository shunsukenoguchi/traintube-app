import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/video_info.dart';

class VideoRepository {
  final DatabaseHelper _db;

  VideoRepository(this._db);

  Future<void> insert(VideoInfo video) async {
    final db = await _db.database;
    await db.insert(
      'videos',
      {
        'id': video.id,
        'url': video.url,
        'title': video.title,
        'channel_name': video.channelName,
        'sort_order': video.sortOrder,
        'category_sort_order': video.categorySortOrder,
        'category_id': video.categoryId,
        'created_at': video.createdAt.toIso8601String(),
        'updated_at': video.updatedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VideoInfo>> getAll() async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query('videos');

    return maps.map((map) => VideoInfo(
      id: map['id'],
      url: map['url'],
      title: map['title'],
      channelName: map['channel_name'],
      sortOrder: map['sort_order'],
      categorySortOrder: map['category_sort_order'],
      categoryId: map['category_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    )).toList();
  }

  Future<VideoInfo?> getById(String id) async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'videos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return VideoInfo(
      id: map['id'],
      url: map['url'],
      title: map['title'],
      channelName: map['channel_name'],
      sortOrder: map['sort_order'],
      categorySortOrder: map['category_sort_order'],
      categoryId: map['category_id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Future<void> update(VideoInfo video) async {
    final db = await _db.database;
    await db.update(
      'videos',
      {
        'url': video.url,
        'title': video.title,
        'channel_name': video.channelName,
        'sort_order': video.sortOrder,
        'category_sort_order': video.categorySortOrder,
        'category_id': video.categoryId,
        'updated_at': video.updatedAt.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [video.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db.database;
    await db.delete(
      'videos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
