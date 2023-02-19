import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tech_challenge/model/videos.dart';
import 'package:tech_challenge/services/videos_service.dart';
import 'package:tech_challenge/widgets/snackbar_widget.dart';
import 'package:video_player/video_player.dart';

class MainController extends GetxController with StateMixin<List<Videos>> {
  RxInt selectedCategory = 0.obs;
  final VideosService _videosService = VideosServiceImpl(DefaultCacheManager());
  List<Videos> _videos = [];
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  fetchVideos() async {
    try {
      List<Videos> videos = await _videosService.fetchVideos();
      if (videos.isNotEmpty) {
        _videos = videos;
        change(_videos, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      showMessage(e.toString());
    }
  }

  Future<VideoPlayerController> getVideoController({required String url}) async {
    return await _videosService.videoPlayerController(url: url);
  }

  filterVideoByCategory({required String category}) {
    change(null, status: RxStatus.loading());
    List<Videos> videos =
        _videos.where((element) => element.category == category).toList();
    if (videos.isNotEmpty) {
      change(videos, status: RxStatus.success());
    } else {
      change(videos, status: RxStatus.empty());
    }
  }

  fetchAllVideos(){
    change(_videos, status: RxStatus.success());
  }

}
