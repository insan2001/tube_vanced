import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// single video
Future<Video> getLatestVideoFromChannel(String channelId) {
  YoutubeExplode yt = YoutubeExplode();
  return yt.channels.getUploads(channelId).first.then((video) {
    yt.close();
    return video;
  });
}

// single channel
Future<Channel> getChannelInfoByID(String channelId) {
  YoutubeExplode yt = YoutubeExplode();
  return yt.channels.get(channelId).then((channel) {
    yt.close();
    return channel;
  });
}
