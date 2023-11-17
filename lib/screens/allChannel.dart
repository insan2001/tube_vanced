import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/screens/channel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DisplayChannelScreen extends StatefulWidget {
  const DisplayChannelScreen({super.key});

  @override
  State<DisplayChannelScreen> createState() => _DisplayChannelScreenState();
}

class _DisplayChannelScreenState extends State<DisplayChannelScreen> {
  List<Channel> channels = [];

  removeChannel(Channel channel) async {
    List<String> myChannels = prefs.getStringList(prefKey) ?? [];
    myChannels.remove(channel.id.toString());

    await prefs.setStringList(prefKey, myChannels);
    setState(() {
      channels.remove(channel);
      previousDataSet.remove(channel);
    });
  }

  @override
  void initState() {
    previousDataSet.forEach((key, value) {
      channels.add(value.item2);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          previousDataSet.forEach((key, value) {
            if (!channels.contains(value.item2)) {
              channels.add(value.item2);
            }
          });
          setState(() {
            channels;
          });
        },
        child: ListView.builder(
          itemCount: channels.length,
          itemBuilder: (context, index) => Card(
            color: Colors.grey,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChannelScreen(
                            data: previousDataSet[
                                channels[index].id.toString()]!)));
              },
              leading: CircleAvatar(
                maxRadius: 30,
                foregroundImage: CachedNetworkImageProvider(
                  channels[index].logoUrl,
                ),
              ),
              title: Text(channels[index].title),
              subtitle: Text("${channels[index].subscribersCount} Subscribers"),
              trailing: TextButton(
                  onPressed: () {
                    removeChannel(channels[index]);
                  },
                  child: const Text(
                    "Remove",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
