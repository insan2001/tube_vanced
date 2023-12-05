import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Map<String, Channel> channelCache = {};
Map<String, Video> videoCache = {};

// single video
Future<Video> getLatestVideoFromChannel(String channelId) async {
  if (videoCache.containsKey(channelId)) {
    return videoCache[channelId]!;
  } else {
    Video video = await yt.channels.getUploads(channelId).first;
    videoCache[channelId] = video;
    return video;
  }
}

// single channel
Future<Channel> getChannelInfoByID(String channelId) async {
  if (channelCache.containsKey(channelId)) {
    return channelCache[channelId]!;
  } else {
    Channel channel = await yt.channels.get(channelId);
    channelCache[channelId] = channel;
    return channel;
  }
}
