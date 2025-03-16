import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_info.freezed.dart';
part 'video_info.g.dart';

@freezed
class VideoInfo with _$VideoInfo {
  const factory VideoInfo({
    required String url,
    required String title,
    required String channelName,
    required int index,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VideoInfo;

  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
}
