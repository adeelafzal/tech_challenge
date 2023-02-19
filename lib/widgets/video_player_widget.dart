import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/controller/main_controller.dart';
import 'package:tech_challenge/model/videos.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key? key, required this.video}) : super(key: key);
  final Videos video;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;
  final MainController _videoPlayerController = Get.find();

  @override
  initState() {
    _videoPlayerController.isInitialized = false.obs;
    WidgetsBinding.instance.addPostFrameCallback((_){
      initVideo();
    });
    super.initState();
  }

  initVideo() async {
    videoPlayerController = await _videoPlayerController.getVideoController(url: widget.video.url)
      ..initialize().then((value) {
        _videoPlayerController.isInitialized.value = true;
        videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildVideoContainer(), _buildVideoInfo()],
    );
  }

  Positioned _buildVideoInfo() {
    return Positioned(
      right: 13,
      bottom: 100,
      child: Column(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.video.likes}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Icon(
            Icons.category,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.video.category}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Container _buildVideoContainer() {
    return Container(
      width: Get.size.width,
      height: Get.size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: Obx(() => _videoPlayerController.isInitialized.value
          ? VideoPlayer(videoPlayerController)
          : Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.video.thumbnail,
                  fit: BoxFit.cover,
                ),
                const CircularProgressIndicator(),
              ],
            )),
    );
  }
}
