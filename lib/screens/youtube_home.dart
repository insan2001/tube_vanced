// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: myChannelList.length,
            itemBuilder: (context, index) => FutureBuilder(
                future: context
                    .watch<FunctionProvider>()
                    .getRequiredInfo(myChannelList[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something gone wrong"));
                  } else if (snapshot.hasData) {
                    return VideoWidget(dataList: snapshot.data!);
                  } else {
                    return const Center(child: Text("Error"));
                  }
                }));
  }
}
