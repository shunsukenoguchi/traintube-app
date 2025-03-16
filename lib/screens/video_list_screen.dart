import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/video_info_provider.dart';
import '../providers/category_provider.dart';
import '../models/video_info.dart';
import 'youtube_player_screen.dart';
import 'video_registration_screen.dart';

class _DismissibleVideoItem extends StatefulWidget {
  final VideoInfo videoInfo;
  final WidgetRef ref;

  const _DismissibleVideoItem({
    required this.videoInfo,
    required this.ref,
    super.key,
  });

  @override
  State<_DismissibleVideoItem> createState() => _DismissibleVideoItemState();
}

class _DismissibleVideoItemState extends State<_DismissibleVideoItem> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    if (_isDeleting) {
      return const SizedBox.shrink();
    }

    return Dismissible(
      key: ValueKey(widget.videoInfo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        setState(() {
          _isDeleting = true;
        });

        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.videoInfo.title}を削除しました'),
            duration: const Duration(seconds: 2),
          ),
        );

        await widget.ref
            .read(videoInfosProvider.notifier)
            .removeVideoInfo(widget.videoInfo.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          title: Text(
            widget.videoInfo.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            widget.videoInfo.channelName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                    (context) => YoutubePlayerScreen(url: widget.videoInfo.url),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoListScreen extends HookConsumerWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorys = ref.watch(categorysProvider);

    return categorys.when(
      data:
          (categoryList) => DefaultTabController(
            length: categoryList.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('動画一覧'),
                bottom: TabBar(
                  isScrollable: true,
                  tabs:
                      categoryList
                          .map((category) => Tab(text: category.name))
                          .toList(),
                ),
              ),
              body: TabBarView(
                children:
                    categoryList.map((category) {
                      return Builder(
                        builder: (context) {
                          final videoInfos = ref.watch(videoInfosProvider);
                          final index = categoryList.indexOf(category);

                          return videoInfos.when(
                            data: (videos) {
                              final filteredVideos =
                                  videos.where((video) {
                                      if (index == 0) {
                                        return true;
                                      }
                                      return video.categoryId == category.id;
                                    }).toList()
                                    ..sort((a, b) {
                                      if (index == 0) {
                                        return a.sortOrder.compareTo(
                                          b.sortOrder,
                                        );
                                      }
                                      return a.categorySortOrder.compareTo(
                                        b.categorySortOrder,
                                      );
                                    });

                              return filteredVideos.isEmpty
                                  ? const Center(child: Text('動画が登録されていません'))
                                  : ReorderableListView.builder(
                                    itemCount: filteredVideos.length,
                                    onReorder: (oldIndex, newIndex) {
                                      if (oldIndex < newIndex) {
                                        newIndex -= 1;
                                      }
                                      final VideoInfo item =
                                          filteredVideos[oldIndex];
                                      ref
                                          .read(videoInfosProvider.notifier)
                                          .updateCategorySortOrder(
                                            item.url,
                                            newIndex,
                                            category.id,
                                          );
                                    },
                                    itemBuilder: (context, index) {
                                      final videoInfo = filteredVideos[index];
                                      return _DismissibleVideoItem(
                                        key: ValueKey(videoInfo.id),
                                        videoInfo: videoInfo,
                                        ref: ref,
                                      );
                                    },
                                  );
                            },
                            loading:
                                () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            error: (error, stack) {
                              print("=========== error =========== $error");
                              return Center(child: Text('エラーが発生しました: $error'));
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
          ),
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (error, stack) =>
              Scaffold(body: Center(child: Text('エラーが発生しました: $error'))),
    );
  }
}
