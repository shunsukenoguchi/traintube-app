import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/video_info_provider.dart';
import 'youtube_player_screen.dart';
import 'video_registration_screen.dart';

class VideoListScreen extends HookConsumerWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoInfos = ref.watch(videoInfosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('動画一覧')),
      body:
          videoInfos.isEmpty
              ? const Center(child: Text('動画が登録されていません'))
              : ListView.builder(
                itemCount: videoInfos.length,
                itemBuilder: (context, index) {
                  final videoInfo = videoInfos[index];
                  return Padding(
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
                            builder:
                                (context) =>
                                    YoutubePlayerScreen(url: videoInfo.url),
                          ),
                        );
                      },
                    ),
                  );
                },
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
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
