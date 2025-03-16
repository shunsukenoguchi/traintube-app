import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/video_record.dart';

part 'video_record_provider.g.dart';

@riverpod
class VideoRecords extends _$VideoRecords {
  @override
  List<VideoRecord> build() {
    return [];
  }

  void addRecord(VideoRecord record) {
    state = [...state, record];
  }
}
