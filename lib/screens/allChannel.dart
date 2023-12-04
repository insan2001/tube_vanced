import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/custom_widget/text.dart';
import 'package:youtube_clone/notify.dart';
import 'package:youtube_clone/screens/channel.dart';

class DisplayChannelScreen extends StatefulWidget {
  const DisplayChannelScreen({super.key});

  @override
  State<DisplayChannelScreen> createState() => _DisplayChannelScreenState();
}

class _DisplayChannelScreenState extends State<DisplayChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: context.watch<ValueProvider>().channelData.isEmpty
          ? const Center(child: MyText(data: "Add some channels to begin"))
          : ListView.builder(
              itemCount: context.watch<ValueProvider>().channelData.length,
              itemBuilder: (context, index) => Card(
                color: Colors.grey,
                child: ListTile(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ChannelScreen(
                  //           data: context
                  //               .read<ValueProvider>()
                  //               .channelData[index]),
                  //     ),
                  //   );
                  // },
                  leading: CircleAvatar(
                    maxRadius: 30,
                    foregroundImage: CachedNetworkImageProvider(
                      context
                          .watch<ValueProvider>()
                          .channelData[index]
                          .item2
                          .logoUrl,
                    ),
                  ),
                  title: Text(context
                      .watch<ValueProvider>()
                      .channelData[index]
                      .item2
                      .title),
                  subtitle: Text(
                      "${context.watch<ValueProvider>().channelData[index].item2.subscribersCount} Subscribers"),
                  trailing: TextButton(
                      onPressed: () {
                        context.read<ValueProvider>().removeValue(index);
                        setState(() {});
                      },
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ),
    );
  }
}
