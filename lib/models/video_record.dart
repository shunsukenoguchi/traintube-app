import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_record.freezed.dart';
part 'video_record.g.dart';

@freezed
class VideoRecord with _$VideoRecord {
  const factory VideoRecord({
    required String videoId,
    required String title,
    required String channelName,
    required DateTime recordedAt,
  }) = _VideoRecord;

  factory VideoRecord.fromJson(Map<String, dynamic> json) =>
      _$VideoRecordFromJson(json);
}
