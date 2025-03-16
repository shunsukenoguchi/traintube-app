import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_info.dart';
import '../providers/video_info_provider.dart';
import '../providers/workout_provider.dart';
import 'package:uuid/uuid.dart';

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
    final selectedWorkoutId = useState<String?>(null);
    final workouts = ref.watch(workoutsProvider);

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
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final newVideoId = YoutubePlayer.convertUrlToId(value);
                    if (newVideoId != null && newVideoId != videoId.value) {
                      videoId.value = newVideoId;
                      controller.value?.dispose();
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
              if (workouts.isNotEmpty) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<String?>(
                  value: selectedWorkoutId.value,
                  decoration: const InputDecoration(
                    labelText: 'ワークアウト',
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('選択なし'),
                    ),
                    ...workouts.map((workout) {
                      return DropdownMenuItem<String?>(
                        value: workout.id,
                        child: Text(workout.name),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    selectedWorkoutId.value = value;
                  },
                ),
              ],
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
          return SingleChildScrollView(
            child: Column(
              children: [
                // URL入力フォーム
                buildUrlForm(),
                player,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
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
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),
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
                                    id: const Uuid().v4(),
                                    title: controller.value!.metadata.title,
                                    channelName:
                                        controller.value!.metadata.author,
                                    url: urlController.text,
                                    index: videoInfos.length,
                                    createdAt: DateTime.now(),
                                    updatedAt: DateTime.now(),
                                    workoutId: selectedWorkoutId.value,
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
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
