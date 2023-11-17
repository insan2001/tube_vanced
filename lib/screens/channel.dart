import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widget/video.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ChannelScreen extends StatefulWidget {
  final Tuple<ChannelUploadsList, Channel> data;
  const ChannelScreen({super.key, required this.data});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  late String url;

  @override
  Widget build(BuildContext context) {
    if (widget.data.item2.bannerUrl == "") {
      url =
          "https://th.bing.com/th/id/R.0cb9533bf1c4edf5d68872dd429f770c?rik=JSCJXJyz4%2f3qvg&pid=ImgRaw&r=0";
    } else {
      url = widget.data.item2.bannerUrl;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.black,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.width / 16 * 4.36,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: CircleAvatar(
                  foregroundImage:
                      CachedNetworkImageProvider(widget.data.item2.logoUrl),
                ),
                background: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList.builder(
              itemCount: widget.data.item1.length,
              itemBuilder: (context, index) => VideoWidget(
                dataList: Tuple(widget.data.item1[index], widget.data.item2),
                navigation: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
