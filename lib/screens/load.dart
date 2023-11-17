import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/screens/youtube.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Tuple<ChannelUploadsList, Channel>> dataList = [];
    if (previousDataSet.isNotEmpty) {
      previousDataSet.forEach((key, value) {
        dataList.add(value);
      });
      return YoutubeScreen(dataList: dataList);
    } else {
      return FutureBuilder(
          future: getAllChannelInfo(prefs.getStringList(prefKey) ?? [], false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LinearProgressIndicator());
            } else if (snapshot.hasData) {
              List<Tuple<ChannelUploadsList, Channel>> dataList =
                  snapshot.data!;

              return YoutubeScreen(dataList: dataList);
            } else {
              return const Center(child: Text("Failed to load data."));
            }
          });
    }
  }
}
