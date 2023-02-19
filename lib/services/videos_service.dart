import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tech_challenge/model/videos.dart';
import 'package:video_player/video_player.dart';

abstract class VideosService {
  Future<List<Videos>> fetchVideos();
  Future<VideoPlayerController> videoPlayerController({required String url});
}

class VideosServiceImpl extends VideosService {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Videos');
  late BaseCacheManager _cacheManager;

  VideosServiceImpl(this._cacheManager) : assert(_cacheManager != null);

  @override
  Future<List<Videos>> fetchVideos() async{
    QuerySnapshot querySnapshot = await _collectionRef.get();
    List<Videos> videos = querySnapshot.docs.map((doc) => Videos.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return videos;
  }

  @override
  Future<VideoPlayerController> videoPlayerController({required String url}) async {
    final fileInfo = await _cacheManager.getFileFromCache(url);

    if (fileInfo == null || fileInfo.file == null) {
      print('[VideoControllerService]: No video in cache');

      print('[VideoControllerService]: Saving video to cache');
      unawaited(_cacheManager.downloadFile(url));

      return VideoPlayerController.network(url);
    } else {
      print('[VideoControllerService]: Loading video from cache');
      return VideoPlayerController.file(fileInfo.file);
    }
  }
}