import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/screens/channel.dart';
import 'package:youtube_clone/screens/player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoWidget extends StatelessWidget {
  final Tuple<Video, Channel>? dataList;
  const VideoWidget({super.key, this.dataList});

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
                onTap: () => dataList != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                YoutubePlayerScreen(video: dataList!.item1)))
                    : null,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 9 / 16,
                  child: dataList != null
                      ? CachedNetworkImage(
                          imageUrl: dataList!.item1.thumbnails.highResUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor:
                                    const Color.fromARGB(255, 80, 226, 212),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      9 /
                                      16,
                                ),
                              ),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          })
                      : null,
                ),
              ),
              ListTile(
                onTap: () => dataList == null
                    ? null
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChannelScreen(channel: dataList!.item2),
                        ),
                      ),
                leading: CircleAvatar(
                  foregroundImage: dataList == null
                      ? null
                      : CachedNetworkImageProvider(dataList!.item2.logoUrl),
                ),
                title: dataList == null
                    ? null
                    : Text(
                        dataList!.item1.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                subtitle: dataList == null
                    ? null
                    : Text(
                        "${dataList!.item1.author} . ${dataList!.item1.uploadDateRaw}",
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
