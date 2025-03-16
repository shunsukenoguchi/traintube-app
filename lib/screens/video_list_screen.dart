import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/video_info_provider.dart';
import '../providers/category_provider.dart';
import '../models/video_info.dart';
import 'youtube_player_screen.dart';
import 'video_registration_screen.dart';

class VideoListScreen extends HookConsumerWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorys = ref.watch(categorysProvider);

    return DefaultTabController(
      length: categorys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('動画一覧'),
          bottom: TabBar(
            isScrollable: true,
            tabs:
                categorys.map((category) => Tab(text: category.name)).toList(),
          ),
        ),
        body: TabBarView(
          children:
              categorys.map((category) {
                return Builder(
                  builder: (context) {
                    final videoInfos = ref.watch(videoInfosProvider);
                    final index = categorys.indexOf(category);

                    final filteredVideos =
                        videoInfos.where((video) {
                          if (index == 0) {
                            // 全ての動画の場合はグローバルインデックスでソート
                            return true;
                          }
                          return video.categoryId == category.id;
                        })
                        .toList()
                        ..sort((a, b) {
                          if (index == 0) {
                            return a.index.compareTo(b.index);
                          }
                          return a.categoryIndex.compareTo(b.categoryIndex);
                        });

                    return filteredVideos.isEmpty
                        ? const Center(child: Text('動画が登録されていません'))
                        : ReorderableListView.builder(
                          itemCount: filteredVideos.length,
                          onReorder: (oldIndex, newIndex) {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final VideoInfo item = filteredVideos[oldIndex];
                            ref
                                .read(videoInfosProvider.notifier)
                                .updateIndex(item.url, newIndex, category.id);
                          },
                          itemBuilder: (context, index) {
                            final videoInfo = filteredVideos[index];
                            return Padding(
                              key: Key(videoInfo.id),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: ListTile(
                                title: Text(
                                  videoInfo.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  videoInfo.channelName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.black87,
                                  size: 28,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => YoutubePlayerScreen(
                                            url: videoInfo.url,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                  },
                );
              }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VideoRegistrationScreen(),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }
}
