import 'package:chewie/chewie.dart';
import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String videoUrl;
  const VideoView({super.key, required this.videoUrl});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController videoPlayerController;
  final ValueNotifier<ChewieController?> chewieControllerNotifier =
      ValueNotifier<ChewieController?>(null);

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        AppConstant.imagesBaseURLForAttachmentArchive + widget.videoUrl);
    await videoPlayerController.initialize().whenComplete(() {
      chewieControllerNotifier.value = ChewieController(
        videoPlayerController: videoPlayerController,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieControllerNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder<ChewieController?>(
          valueListenable: chewieControllerNotifier,
          builder: (context, snapshot, child) {
            if (snapshot != null) {
              return SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Chewie(
                    controller: snapshot,
                  ),
                ),
              );
            } else {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
