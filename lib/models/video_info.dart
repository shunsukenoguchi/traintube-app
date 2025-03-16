import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'video_info.freezed.dart';
part 'video_info.g.dart';

@freezed
class VideoInfo with _$VideoInfo {
  const factory VideoInfo({
    @Default('') String id,
    required String url,
    required String title,
    required String channelName,
    required int index,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? workoutId,
  }) = _VideoInfo;

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
}
