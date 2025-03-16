import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/video_info.dart';

part 'video_info_provider.g.dart';

@riverpod
class VideoInfos extends _$VideoInfos {
  @override
  List<VideoInfo> build() {
    return [];
  }

  void fetchVideoInfo(String url, {String? categoryId}) async {
    final categoryVideos = categoryId == null 
        ? state 
        : state.where((video) => video.categoryId == categoryId).toList();
    
    final newCategoryIndex = categoryVideos.length;
    
    final videoInfo = VideoInfo(
      id: const Uuid().v4(),
      url: url,
      title: 'title',
      channelName: 'channelName',
      index: state.length,
      categoryIndex: newCategoryIndex,
      categoryId: categoryId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    state = [...state, videoInfo];
  }

  void addVideoInfo(VideoInfo videoInfo) {
    final categoryVideos = videoInfo.categoryId == null 
        ? state 
        : state.where((video) => video.categoryId == videoInfo.categoryId).toList();
    
    final newCategoryIndex = categoryVideos.length;
    
    state = [
      ...state,
      videoInfo.copyWith(
        categoryIndex: newCategoryIndex,
        index: state.length,
      ),
    ];
  }

  void updateIndex(String url, int newIndex, String? categoryId) {
    final targetVideo = state.firstWhere((video) => video.url == url);
    final oldIndex = targetVideo.categoryIndex;
    
    final updatedState = [
      for (final videoInfo in state)
        if (videoInfo.url == url)
          videoInfo.copyWith(
            categoryIndex: newIndex,
            index: categoryId == null ? newIndex : videoInfo.index,
          )
        else if (categoryId != null && videoInfo.categoryId == categoryId)
          videoInfo.copyWith(
            categoryIndex: _adjustIndex(
              currentIndex: videoInfo.categoryIndex,
              oldIndex: oldIndex,
              newIndex: newIndex,
            ),
          )
        else
          videoInfo,
    ];
    
    state = updatedState;
  }

  int _adjustIndex({
    required int currentIndex,
    required int oldIndex,
    required int newIndex,
  }) {
    if (currentIndex < oldIndex && currentIndex < newIndex) {
      return currentIndex;
    }
    if (currentIndex > oldIndex && currentIndex > newIndex) {
      return currentIndex;
    }
    if (currentIndex > oldIndex && currentIndex <= newIndex) {
      return currentIndex - 1;
    }
    if (currentIndex < oldIndex && currentIndex >= newIndex) {
      return currentIndex + 1;
    }
    return currentIndex;
  }

  void removeVideoInfo(String url) {
    state = state.where((element) => element.url != url).toList();
  }
}
