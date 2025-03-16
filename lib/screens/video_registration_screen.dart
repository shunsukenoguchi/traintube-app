import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_info.dart';
import '../providers/video_info_provider.dart';

class VideoRegistrationScreen extends HookConsumerWidget {
  const VideoRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    final isPlaying = useState(false);
    final isMute = useState(true);
    final controller = useState<YoutubePlayerController?>(null);
    final videoId = useState<String?>(null);

    // フォーム部分のウィジェット
    Widget buildUrlForm() {
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: 'YouTubeのURL*',
                  hintText: 'https://www.youtube.com/watch?v=...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URLを入力してください';
                  }
                  final videoId = YoutubePlayer.convertUrlToId(value);
                  if (videoId == null) {
                    return '有効なYouTube URLを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (controller.value == null)
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newVideoId = YoutubePlayer.convertUrlToId(
                        urlController.text,
                      );
                      if (newVideoId != null) {
                        videoId.value = newVideoId;
                        controller.value = YoutubePlayerController(
                          initialVideoId: newVideoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: true,
                            enableCaption: true,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('プレビュー'),
                ),
            ],
          ),
        ),
      );
    }

    // プレーヤーが初期化されている場合のウィジェット
    Widget buildPlayer() {
      if (controller.value == null) return buildUrlForm();

      useEffect(() {
        void listener() {
          isPlaying.value = controller.value!.value.isPlaying;
        }

        controller.value!.addListener(listener);
        return () {
          controller.value!.removeListener(listener);
          controller.value!.dispose();
        };
      }, [controller.value]);

      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.value!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
          onReady: () {},
        ),
        builder: (context, player) {
          return Column(
            children: [
              // URL入力フォーム
              buildUrlForm(),
              // プレーヤー
              player,
              // メタデータ表示
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      controller.value!.metadata.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Channel: ${controller.value!.metadata.author}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    // // コントロールボタン
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //       iconSize: 48,
                    //       icon: const Icon(
                    //         Icons.replay_10,
                    //         color: Colors.black87,
                    //       ),
                    //       onPressed: () {
                    //         final position = controller.value!.value.position;
                    //         controller.value!.seekTo(
                    //           position - const Duration(seconds: 10),
                    //         );
                    //       },
                    //     ),
                    //     const SizedBox(width: 16),
                    //     IconButton(
                    //       iconSize: 64,
                    //       icon: Icon(
                    //         isPlaying.value
                    //             ? Icons.pause_circle_filled
                    //             : Icons.play_circle_filled,
                    //         color: Colors.black87,
                    //       ),
                    //       onPressed: () {
                    //         if (isPlaying.value) {
                    //           controller.value!.pause();
                    //         } else {
                    //           controller.value!.play();
                    //         }
                    //       },
                    //     ),
                    //     const SizedBox(width: 16),
                    //     IconButton(
                    //       iconSize: 48,
                    //       icon: const Icon(
                    //         Icons.forward_10,
                    //         color: Colors.black87,
                    //       ),
                    //       onPressed: () {
                    //         final position = controller.value!.value.position;
                    //         controller.value!.seekTo(
                    //           position + const Duration(seconds: 10),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 24),
                    // 登録ボタン
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final videoInfos = ref.read(videoInfosProvider);
                          ref
                              .read(videoInfosProvider.notifier)
                              .addVideoInfo(
                                VideoInfo(
                                  title: controller.value!.metadata.title,
                                  channelName:
                                      controller.value!.metadata.author,
                                  url: urlController.text,
                                  index: videoInfos.length,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                ),
                              );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.add, size: 28),
                        label: const Text(
                          'この動画を登録',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('動画を登録'),
        actions: [
          if (controller.value != null)
            IconButton(
              icon: Icon(isMute.value ? Icons.volume_up : Icons.volume_off),
              onPressed: () {
                if (isMute.value) {
                  controller.value!.unMute();
                  isMute.value = false;
                } else {
                  controller.value!.mute();
                  isMute.value = true;
                }
              },
            ),
        ],
      ),
      body: buildPlayer(),
    );
  }
}
