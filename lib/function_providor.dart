import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class FunctionProvider extends ChangeNotifier {
  Map<String, Tuple<Video, Channel>> cache = {};
  Map<String, List<Video>> channelVideoListCache = {};
  List<Tuple<Video, Channel>> myList = [];
  List<Tuple<Video, Channel>> watched = [];

  Stream<Tuple<Video, Channel>> getRequiredInfo(
      List<String> myChannelList) async* {
    myList = [];
    for (String channelId in myChannelList) {
      if (cache.containsKey(channelId)) {
        if (!myList.contains(cache[channelId]) &&
            !watched.contains(cache[channelId])) {
          myList.add(cache[channelId]!);
          notifyListeners();
        }
        yield cache[channelId]!;
      } else {
        Channel channel = await getChannelInfoByID(channelId);
        Video video = await getLatestVideoFromChannel(channelId);
        cache[channelId] = Tuple(video, channel);
        if (!myList.contains(cache[channelId]) &&
            !watched.contains(cache[channelId])) {
          myList.add(cache[channelId]!);
          notifyListeners();
        }
        yield Tuple(video, channel);
      }
    }
  }

  Future<List<Video>> getAllVideos(String channelId) async {
    if (channelVideoListCache.containsKey(channelId)) {
      return channelVideoListCache[channelId]!;
    } else {
      List<Video> channelVideos =
          await yt.channels.getUploads(channelId).toList();
      channelVideoListCache[channelId] = channelVideos;
      return channelVideos;
    }
  }
}
