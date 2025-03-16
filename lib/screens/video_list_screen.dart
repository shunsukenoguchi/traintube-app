import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_info.dart';
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
                  return ListTile(
                    title: Text(videoInfo.title),
                    subtitle: Text(videoInfo.channelName),
                    trailing: const Icon(Icons.play_arrow),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  YoutubePlayerScreen(url: videoInfo.url),
                        ),
                      );
                    },
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
