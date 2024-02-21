// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/function_providor.dart';
import 'package:youtube_clone/main.dart';

class YoutubehomeScreen extends StatefulWidget {
  const YoutubehomeScreen({super.key});

  @override
  State<YoutubehomeScreen> createState() => _YoutubehomeScreenState();
}

class _YoutubehomeScreenState extends State<YoutubehomeScreen> {
  List<String> myChannelList = [];

  @override
  void didChangeDependencies() {
    myChannelList = prefs.getStringList(prefKey) ?? [];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myChannelList = prefs.getStringList(prefKey) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myChannelList.isEmpty
        ? const Center(
            child: Text("Subscribe to some channel to get feed",
                style: TextStyle(color: Colors.white70)))
        : StreamBuilder(
            stream: context
                .watch<FunctionProvider>()
                .getRequiredInfo(myChannelList),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: myChannelList.length,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 192, 192, 192),
                    highlightColor: Colors.black,
                    child: const VideoWidget(),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: context.watch<FunctionProvider>().myList.length,
                  itemBuilder: (context, index) => VideoWidget(
                    dataList: context.watch<FunctionProvider>().myList[index],
                  ),
                );
              } else {
                return const Center(child: Text("Something went wrong!"));
              }
            });
  }
}
