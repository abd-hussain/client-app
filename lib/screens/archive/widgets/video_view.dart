import 'package:client_app/utils/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String videoUrl;
  const VideoView({super.key, required this.videoUrl});

  @override
  State<VideoView> createState() => _VideoViewState();
}

//TODO: Video not working on IOS
class _VideoViewState extends State<VideoView> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          AppConstant.imagesBaseURLForAttachmentArchive + widget.videoUrl),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            child: videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  )
                : Container(),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(
                videoPlayerController.value.isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
                color: const Color(0xff034061),
                size: 75,
              ),
              onPressed: () {
                setState(() {
                  videoPlayerController.value.isPlaying
                      ? videoPlayerController.pause()
                      : videoPlayerController.play();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
