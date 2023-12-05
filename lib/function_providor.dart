import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class FunctionProvider extends ChangeNotifier {
  Map<String, Tuple<Video, Channel>> cache = {};

  Future<Tuple<Video, Channel>> getRequiredInfo(String channelId) async {
    if (cache.containsKey(channelId)) {
      return cache[channelId]!;
    } else {
      Channel channel = await getChannelInfoByID(channelId);
      Video video = await getLatestVideoFromChannel(channelId);
      cache[channelId] = Tuple(video, channel);
      return Tuple(video, channel);
    }
  }
}
