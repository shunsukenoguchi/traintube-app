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
    final newList = [...state];
    final index = newList.indexWhere((element) => element.url == videoInfo.url);
    if (index == -1) {
      state = [...state, videoInfo];
    }
  }

  void removeVideoInfo(String url) {
    state = state.where((element) => element.url != url).toList();
  }
}
