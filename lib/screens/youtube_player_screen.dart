import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_record.dart';
import '../providers/video_record_provider.dart';

class YoutubePlayerScreen extends HookConsumerWidget {
  const YoutubePlayerScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(
      () => YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          enableCaption: true,
        ),
      ),
    );

    final isPlaying = useState(true);
    final isMute = useState(true);

    useEffect(() {
      void listener() {
        isPlaying.value = controller.value.isPlaying;
      }

      controller.addListener(listener);
      return () {
        controller.removeListener(listener);
        controller.dispose();
      };
    }, [controller]);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          debugPrint('Player is ready.');
        },
        onEnded: (data) {
          debugPrint('Video ended');
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('YouTube Player'),
            actions: [
              IconButton(
                icon: Icon(isMute.value ? Icons.volume_up : Icons.volume_off),
                onPressed: () {
                  if (isMute.value) {
                    controller.unMute();
                    isMute.value = false;
                  } else {
                    controller.mute();
                    isMute.value = true;
                  }
                },
              ),
            ],
          ),
          body: Column(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.metadata.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Channel: ${controller.metadata.author}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 48,
                          icon: const Icon(
                            Icons.replay_10,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            final position = controller.value.position;
                            controller.seekTo(
                              position - const Duration(seconds: 10),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          iconSize: 60,
                          icon: Icon(
                            isPlaying.value
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            if (isPlaying.value) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          },
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          iconSize: 48,
                          icon: const Icon(
                            Icons.forward_10,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            final position = controller.value.position;
                            controller.seekTo(
                              position + const Duration(seconds: 10),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 48,
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            final videoId = YoutubePlayer.convertUrlToId(url);
                            if (videoId != null) {
                              final record = VideoRecord(
                                videoId: videoId,
                                title: controller.metadata.title,
                                channelName: controller.metadata.author,
                                recordedAt: DateTime.now(),
                              );
                              ref
                                  .read(videoRecordsProvider.notifier)
                                  .addRecord(record);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('動画を記録しました'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
