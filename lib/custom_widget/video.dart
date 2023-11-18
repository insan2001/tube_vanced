import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/screens/player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoWidget extends StatelessWidget {
  final Tuple<Video, Channel> dataList;
  final Function navigation;
  const VideoWidget(
      {super.key, required this.dataList, required this.navigation});

  final double BOTTOMSIZE = 60;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9 / 16 + BOTTOMSIZE,
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
              GestureDetector(
                onTap: () => navigation(),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  width: MediaQuery.of(context).size.width,
                  height: BOTTOMSIZE,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                        child: CircleAvatar(
                          foregroundImage: CachedNetworkImageProvider(
                              dataList.item2.logoUrl),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 8 / 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              dataList.item1.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "${dataList.item1.author} . ${dataList.item1.uploadDateRaw}",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
