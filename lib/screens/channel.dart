import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/subscribe_button.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ChannelScreen extends StatefulWidget {
  final Channel channel;
  const ChannelScreen({super.key, required this.channel});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late String bannerUrl;
  late YoutubeExplode yt;
  bool isSub = false;

  @override
  void initState() {
    yt = YoutubeExplode();

    if (widget.channel.bannerUrl == "") {
      bannerUrl =
          "https://th.bing.com/th/id/R.0cb9533bf1c4edf5d68872dd429f770c?rik=JSCJXJyz4%2f3qvg&pid=ImgRaw&r=0";
    } else {
      bannerUrl = widget.channel.bannerUrl;
    }
    super.initState();
  }

  @override
  void dispose() {
    yt.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: yt.channels.getUploads(widget.channel.id).toList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something gone wrong"));
              } else if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.black,
                      actions: [
                        SubscribeButton(channelId: widget.channel.id.toString())
                      ],
                      floating: true,
                      expandedHeight:
                          MediaQuery.of(context).size.width / 16 * 4.36,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(
                              widget.channel.logoUrl),
                        ),
                        background: CachedNetworkImage(
                          imageUrl: bannerUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return VideoWidget(
                            dataList:
                                Tuple(snapshot.data![index], widget.channel),
                          );
                        }),
                  ],
                );
              } else {
                return const Center(child: Text("Error"));
              }
            }),
      ),
    );
  }
}
