import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/video_info_provider.dart';
import '../providers/workout_provider.dart';
import '../models/video_info.dart';
import '../models/workout.dart';
import 'youtube_player_screen.dart';
import 'video_registration_screen.dart';

class VideoListScreen extends ConsumerWidget {
  const VideoListScreen({super.key});

  static const List<String> categories = ['全て', '胸', '背中', '腕', '肩', '脚'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('動画一覧'),
          bottom: TabBar(
            isScrollable: true,
            tabs: categories
                .map((category) => Tab(text: category))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            return Builder(
              builder: (context) {
                final videoInfos = ref.watch(videoInfosProvider);
                final index = categories.indexOf(category);
                
                final filteredVideos = videoInfos.where((video) {
                  if (index == 0) return true;
                  return video.workoutId == category;
                }).toList();

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
                              .updateIndex(item.url, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final videoInfo = filteredVideos[index];
                          return Padding(
                            key: Key(videoInfo.id),
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                                    builder: (context) =>
                                        YoutubePlayerScreen(url: videoInfo.url),
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
