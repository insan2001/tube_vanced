import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/screens/channel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Tuple<Video, Channel>> dataList = [];
  List<Channel> channelList = [];
  bool searching = false;
  bool switchState = false;

  void search() async {
    setState(() {
      searching = true;
      dataList = [];
    });
    var yt = YoutubeExplode();
    if (!switchState) {
      var results = await yt.search.search(_controller.text);
      for (var video in results) {
        Channel channel = await yt.channels.get(video.channelId);
        setState(() {
          dataList.add(Tuple(video, channel));
        });
      }
    } else {
      // implement search channels
    }

    setState(() {
      searching = false;
    });

    yt.close();
  }

  void toggleSwitch(bool value) {
    setState(() {
      switchState = value;
      channelList = [];
      dataList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: TextField(
          controller: _controller,
        ),
        actions: [
          // Switch(value: switchState, onChanged: (value) => toggleSwitch(value)),
          IconButton(
            onPressed: search,
            icon: searching
                ? const CircularProgressIndicator()
                : const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) => switchState
            ? ListTile(
                leading: CircleAvatar(
                  child:
                      CachedNetworkImage(imageUrl: channelList[index].logoUrl),
                ),
                title: Text(channelList[index].title),
                trailing: const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.add),
                ),
              )
            : VideoWidget(
                dataList: dataList[index],
                navigation: () {
                  getChannelInfo(dataList[index].item2.id.toString(), context)
                      .then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChannelScreen(
                          data: value,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
