import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Tuple<Video, Channel>> dataList = [];
  List<Channel> channelList = [];
  bool searching = false;
  bool switchState = false;

  void search(String text) async {
    setState(() {
      searching = true;
      dataList = [];
    });
    if (!switchState) {
      var results = await yt.search.search(text);
      for (var video in results) {
        Channel channel = await getChannelInfoByID(video.channelId.toString());
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
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                search(text);
              },
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: "Search Channel",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
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
              ),
      ),
    );
  }
}
