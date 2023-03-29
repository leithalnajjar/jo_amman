import 'package:jo_amman/ui/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoViewerController controller = VideoViewerController();

  // ChewieController? _chewieController;
  // VideoPlayerController? _videoPlayerController;

  // @override
  // void initState() {
  //   super.initState();
  //   _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
  //   _chewieController = ChewieController(
  //     videoPlayerController: _videoPlayerController!,
  //     aspectRatio: _videoPlayerController!.value.aspectRatio * 2,
  //     autoInitialize: true,
  //     allowedScreenSleep: false,
  //     autoPlay: true,
  //     looping: false,
  //     errorBuilder: (context, errorMessage) {
  //       return Center(
  //         child: Text(
  //           errorMessage,
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       );
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _chewieController?.pause();
  //   _chewieController?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Video'.tr,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: VideoViewer(
              autoPlay: true,
              enableHorizontalSwapingGesture: false,
              enableVerticalSwapingGesture: false,
              controller: controller,
              source: {
                "": VideoSource(
                  video: VideoPlayerController.network(widget.videoUrl),
                  // subtitle: {
                  //   "English": VideoViewerSubtitle.network(
                  //     "https://felipemurguia.com/assets/txt/WEBVTT_English.txt",
                  //     type: SubtitleType.webvtt,
                  //   ),
                  // },
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}
