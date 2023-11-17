import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Map<String, Tuple<ChannelUploadsList, Channel>> previousDataSet = {};

Future<List<Tuple<ChannelUploadsList, Channel>>> getAllChannelInfo(
  List<String> channelIdList,
  bool ignorePrevious,
) async {
  var yt = YoutubeExplode();

  List<Tuple<ChannelUploadsList, Channel>> dataList = [];
  for (String channelID in channelIdList) {
    Tuple<ChannelUploadsList, Channel> data;

    if (previousDataSet.containsKey(channelID) && !ignorePrevious) {
      data = previousDataSet[channelID]!;
    } else {
      Channel channel = await yt.channels.get(channelID);
      ChannelUploadsList videoList =
          await yt.channels.getUploadsFromPage(channelID);

      data = Tuple(videoList, channel);
      previousDataSet[channelID] = data;
    }
    dataList.add(data);
  }
  yt.close();
  return dataList;
}

Future<Channel> getChannelID(String link) async {
  var yt = YoutubeExplode();
  Channel channel = await yt.channels.getByVideo(link);
  yt.close();
  return channel;
}
