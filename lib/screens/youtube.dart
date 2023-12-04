// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/notify.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  SearchController searchControl = SearchController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<ValueProvider>().channelData.isEmpty
        ? const Center(
            child: Text("Add your prefered channel",
                style: TextStyle(color: Colors.white70)))
        : RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              Provider.of<ValueProvider>(context, listen: false).sortData();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: context.watch<ValueProvider>().channelData.length,
              itemBuilder: (context, index) => VideoWidget(
                dataList: Tuple(
                  context.watch<ValueProvider>().channelData[index].item1.first,
                  context.watch<ValueProvider>().channelData[index].item2,
                ),
              ),
            ),
          );
  }
}
