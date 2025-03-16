import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../db/database_helper.dart';
import '../models/video_info.dart';
import '../repositories/video_repository.dart';

part 'video_info_provider.g.dart';

@Riverpod(keepAlive: true)
class VideoInfos extends AsyncNotifier<List<VideoInfo>> {
  final VideoRepository _repository = VideoRepository(DatabaseHelper.instance);

  @override
  Future<List<VideoInfo>> build() async {
    return _repository.getAll();
  }

  Future<void> fetchVideoInfo(String url, {String? categoryId}) async {
    final videos = await _repository.getAll();
    final categoryVideos =
        categoryId == null
            ? videos
            : videos.where((video) => video.categoryId == categoryId).toList();

    final newCategorySortOrder = categoryVideos.length;

    final newVideo = VideoInfo(
      id: const Uuid().v4(),
      url: url,
      title: 'title',
      channelName: 'channelName',
      sortOrder: videos.length,
      categorySortOrder: newCategorySortOrder,
      categoryId: categoryId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _repository.insert(newVideo);
    ref.invalidateSelf();
  }

  Future<void> addVideoInfo(VideoInfo videoInfo) async {
    final videos = await _repository.getAll();
    final categoryVideos =
        videoInfo.categoryId == null
            ? videos
            : videos
                .where((video) => video.categoryId == videoInfo.categoryId)
                .toList();

    final newCategorySortOrder = categoryVideos.length;

    final updatedVideo = videoInfo.copyWith(
      categorySortOrder: newCategorySortOrder,
      sortOrder: videos.length,
    );

    await _repository.insert(updatedVideo);
    ref.invalidateSelf();
  }

  Future<void> updateCategorySortOrder(
    String url,
    int newCategorySortOrder,
    String? categoryId,
  ) async {
    final videos = await _repository.getAll();
    final targetVideo = videos.firstWhere((video) => video.url == url);
    final oldCategorySortOrder = targetVideo.categorySortOrder;

    final updatedVideos = [
      for (final videoInfo in videos)
        if (videoInfo.url == url)
          videoInfo.copyWith(
            categorySortOrder: newCategorySortOrder,
            sortOrder:
                categoryId == null ? newCategorySortOrder : videoInfo.sortOrder,
          )
        else if (categoryId != null && videoInfo.categoryId == categoryId)
          videoInfo.copyWith(
            categorySortOrder: _adjustCategorySortOrder(
              currentSortOrder: videoInfo.categorySortOrder,
              oldCategorySortOrder: oldCategorySortOrder,
              newCategorySortOrder: newCategorySortOrder,
            ),
          )
        else
          videoInfo,
    ];

    // バッチ更新
    await Future.wait(updatedVideos.map((video) => _repository.update(video)));
    ref.invalidateSelf();
  }

  int _adjustCategorySortOrder({
    required int currentSortOrder,
    required int oldCategorySortOrder,
    required int newCategorySortOrder,
  }) {
    if (currentSortOrder < oldCategorySortOrder &&
        currentSortOrder < newCategorySortOrder) {
      return currentSortOrder;
    }
    if (currentSortOrder > oldCategorySortOrder &&
        currentSortOrder > newCategorySortOrder) {
      return currentSortOrder;
    }
    if (currentSortOrder > oldCategorySortOrder &&
        currentSortOrder <= newCategorySortOrder) {
      return currentSortOrder - 1;
    }
    if (currentSortOrder < oldCategorySortOrder &&
        currentSortOrder >= newCategorySortOrder) {
      return currentSortOrder + 1;
    }
    return currentSortOrder;
  }

  Future<void> removeVideoInfo(String url) async {
    final videos = await _repository.getAll();
    final targetVideo = videos.firstWhere((video) => video.url == url);
    await _repository.delete(targetVideo.id);
    ref.invalidateSelf();
  }
}
