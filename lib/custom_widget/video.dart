import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/screens/channel.dart';
import 'package:youtube_clone/screens/player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoWidget extends StatelessWidget {
  final Tuple<Video, Channel> dataList;
  const VideoWidget({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            YoutubePlayerScreen(video: dataList.item1))),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 9 / 16,
                  child: CachedNetworkImage(
                      imageUrl: dataList.item1.thumbnails.highResUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      }),
                ),
              ),
              ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChannelScreen(channel: dataList.item2),
                  ),
                ),
                leading: CircleAvatar(
                  foregroundImage:
                      CachedNetworkImageProvider(dataList.item2.logoUrl),
                ),
                title: Text(
                  dataList.item1.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  "${dataList.item1.author} . ${dataList.item1.uploadDateRaw}",
                  style: const TextStyle(color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
