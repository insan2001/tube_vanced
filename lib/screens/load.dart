import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/custom_widget/text.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/notify.dart';
import 'package:youtube_clone/screens/youtube.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = prefs.getStringList(prefKey) ?? [];
    if (Provider.of<ValueProvider>(context, listen: false).dataSet.isNotEmpty) {
      return const YoutubeScreen();
    } else if (Provider.of<ValueProvider>(context, listen: false)
            .dataSet
            .isEmpty &&
        data.isNotEmpty) {
      return FutureBuilder(
          future: getAllChannelInfo(
              data, false, context.read<ValueProvider>().dataSet),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<Tuple<ChannelUploadsList, Channel>> dataList =
                  snapshot.data!;
              for (var data in dataList) {
                Provider.of<ValueProvider>(context, listen: false)
                    .addValue(data);
              }
              Provider.of<ValueProvider>(context, listen: false).sortData();
              return const YoutubeScreen();
            } else {
              return const Center(child: MyText(data: "Failed to load data."));
            }
          });
    } else {
      return const Center(child: MyText(data: "Add some channel"));
    }
  }
}
