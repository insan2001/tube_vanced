import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/custom_widget/subscribe_button.dart';
import 'package:youtube_clone/custom_widget/text.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/notify.dart';
import 'package:youtube_clone/screens/channel.dart';

class DisplayChannelScreen extends StatefulWidget {
  const DisplayChannelScreen({super.key});

  @override
  State<DisplayChannelScreen> createState() => _DisplayChannelScreenState();
}

class _DisplayChannelScreenState extends State<DisplayChannelScreen> {
  List<String> myChannelList = [];

  @override
  void didChangeDependencies() {
    myChannelList = context.watch<ValueProvider>().myChannels;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myChannelList = context.read<ValueProvider>().myChannels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: myChannelList.isEmpty
          ? const Center(child: MyText(data: "Add some channels to begin"))
          : ListView.builder(
              itemCount: myChannelList.length,
              itemBuilder: (context, index) => Card(
                color: Colors.grey,
                child: FutureBuilder(
                    future: getChannelInfoByID(myChannelList[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text("Something gone wrong"));
                      } else if (snapshot.hasData) {
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChannelScreen(channel: snapshot.data!),
                            ),
                          ),
                          leading: CircleAvatar(
                            maxRadius: 30,
                            foregroundImage: CachedNetworkImageProvider(
                              snapshot.data!.logoUrl,
                            ),
                          ),
                          title: Text(snapshot.data!.title),
                          subtitle: Text(
                              "${snapshot.data!.subscribersCount} Subscribers"),
                          trailing: SubscribeButton(
                              channelId: snapshot.data!.id.toString()),
                        );
                      } else {
                        return const Center(child: Text("Error"));
                      }
                    }),
              ),
            ),
    );
  }
}
