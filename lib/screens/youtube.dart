// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/screens/channel.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeScreen extends StatefulWidget {
  final List<Tuple<ChannelUploadsList, Channel>> dataList;
  const YoutubeScreen({super.key, required this.dataList});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  SearchController searchControl = SearchController();
  late List<Tuple<ChannelUploadsList, Channel>> dataList;

  List<Tuple<ChannelUploadsList, Channel>> sortData(
      List<Tuple<ChannelUploadsList, Channel>> customList) {
    customList.sort((a, b) =>
        a.item1.first.uploadDate!.compareTo(b.item1.first.uploadDate!));

    return customList.reversed.toList();
  }

  void refresh(bool ignore) async {
    List<Tuple<ChannelUploadsList, Channel>> receivedDataList =
        await getAllChannelInfo(prefs.getStringList(prefKey) ?? [], ignore);

    if (!mounted) return;
    setState(() {
      dataList = sortData(receivedDataList);
    });
  }

  @override
  void initState() {
    dataList = sortData(widget.dataList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dataList.isEmpty
        ? const Center(
            child: Text("Add your prefered channel",
                style: TextStyle(color: Colors.white70)))
        : RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              List<Tuple<ChannelUploadsList, Channel>> receivedDataList =
                  await getAllChannelInfo(
                      prefs.getStringList(prefKey) ?? [], true);

              if (!mounted) return;
              setState(() {
                dataList = sortData(receivedDataList);
              });
            },
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (context, index) => VideoWidget(
                      dataList: Tuple(
                        dataList[index].item1.first,
                        dataList[index].item2,
                      ),
                      navigation: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChannelScreen(data: dataList[index])));
                      },
                    )),
          );
  }
}
