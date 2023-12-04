import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Tuple<Video, Channel>> dataList = [];
  bool searching = false;

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
          IconButton(
            onPressed: () async {
              setState(() {
                searching = true;
                dataList = [];
              });
              var yt = YoutubeExplode();
              var results = await yt.search.search(_controller.text);
              for (var video in results) {
                Channel channel = await yt.channels.get(video.channelId);
                setState(() {
                  dataList.add(Tuple(video, channel));
                });
              }
              setState(() {
                searching = false;
              });
            },
            icon: searching
                ? const CircularProgressIndicator()
                : const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) =>
              VideoWidget(dataList: dataList[index], navigation: () {})),
    );
  }
}
