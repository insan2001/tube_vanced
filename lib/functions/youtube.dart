import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/notify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<Tuple<ChannelUploadsList, Channel>> getChannelInfo(
    String channelID, BuildContext context) async {
  var yt = YoutubeExplode();

  return yt.channels.get(channelID).then(
        (Channel channel) => yt.channels
            .getUploadsFromPage(channelID)
            .then((ChannelUploadsList uploadsList) {
          var data = Tuple(uploadsList, channel);
          Provider.of<ValueProvider>(context, listen: false).addValue(data);
          yt.close();
          return data;
        }),
      );
}

Future<void> getAndSetAllChannelInfo(
    List<String> channelIdList,
    bool ignorePrevious,
    Map<String, Tuple<ChannelUploadsList, Channel>> previousDataSet,
    BuildContext context) async {
  for (String channelID in channelIdList) {
    context.read<ValueProvider>().setLoading(true);
    if (previousDataSet.containsKey(channelID) && !ignorePrevious) {
      null;
    } else {
      await getChannelInfo(channelID, context);
    }
  }
}

Future<Channel> getChannelID(String link) async {
  var yt = YoutubeExplode();
  Channel channel = await yt.channels.getByVideo(link);
  yt.close();
  return channel;
}
