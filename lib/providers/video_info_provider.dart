import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/video_info.dart';

part 'video_info_provider.g.dart';

@riverpod
class VideoInfos extends _$VideoInfos {
  @override
  List<VideoInfo> build() {
    return [];
  }

  void addVideoInfo(VideoInfo videoInfo) {
    state = [...state, videoInfo];
  }

  void updateIndex(String url, int index) {
    state = [
      for (final videoInfo in state)
        if (videoInfo.url == url)
          videoInfo.copyWith(index: index)
        else
          videoInfo,
    ];
  }

  void removeVideoInfo(String url) {
    state = state.where((element) => element.url != url).toList();
  }
}
