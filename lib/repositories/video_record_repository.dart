import 'package:sqflite/sqflite.dart';
import '../db/database_helper.dart';
import '../models/video_record.dart';

class VideoRecordRepository {
  final DatabaseHelper _db;

  VideoRecordRepository(this._db);

  Future<void> insert(VideoRecord record) async {
    final db = await _db.database;
    await db.insert(
      'video_records',
      {
        'video_id': record.videoId,
        'title': record.title,
        'channel_name': record.channelName,
        'recorded_at': record.recordedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VideoRecord>> getAll() async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'video_records',
      orderBy: 'recorded_at DESC',
    );

    return maps.map((map) => VideoRecord(
      videoId: map['video_id'],
      title: map['title'],
      channelName: map['channel_name'],
      recordedAt: DateTime.parse(map['recorded_at']),
    )).toList();
  }

  Future<VideoRecord?> getByVideoId(String videoId) async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'video_records',
      where: 'video_id = ?',
      whereArgs: [videoId],
    );

    if (maps.isEmpty) {
      return null;
    }

    final map = maps.first;
    return VideoRecord(
      videoId: map['video_id'],
      title: map['title'],
      channelName: map['channel_name'],
      recordedAt: DateTime.parse(map['recorded_at']),
    );
  }

  Future<void> delete(String videoId) async {
    final db = await _db.database;
    await db.delete(
      'video_records',
      where: 'video_id = ?',
      whereArgs: [videoId],
    );
  }

  Future<List<VideoRecord>> getRecordsByDateRange(DateTime start, DateTime end) async {
    final db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'video_records',
      where: 'recorded_at BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
      orderBy: 'recorded_at DESC',
    );

    return maps.map((map) => VideoRecord(
      videoId: map['video_id'],
      title: map['title'],
      channelName: map['channel_name'],
      recordedAt: DateTime.parse(map['recorded_at']),
    )).toList();
  }
}
