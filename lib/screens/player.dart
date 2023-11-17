import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final Video video;
  const YoutubePlayerScreen({super.key, required this.video});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController ytControl;

  @override
  void initState() {
    ytControl = YoutubePlayerController(
        initialVideoId: widget.video.id.value,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          loop: false,
          mute: false,
        ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    super.initState();
  }

  @override
  void deactivate() {
    ytControl.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    ytControl.dispose();
    super.dispose();
  }

  // getDownloadInfo(bool isAudioOnly) async {
  //   var yt = YoutubeExplode();
  //   var manifest = await yt.videos.streams.getManifest(widget.video.id);
  //   var audio = manifest.audioOnly.withHighestBitrate();
  //   var video = manifest.muxed.bestQuality;

  //   var streamInfo = isAudioOnly ? audio : video;
  //   yt.close();
  //   return streamInfo;
  // }

  // Future<AudioOnlyStreamInfo> getAudioInfo() async {
  //   AudioOnlyStreamInfo data = await getDownloadInfo(true);
  //   return data;
  // }

  // Future<MuxedStreamInfo> getVideoInfo() async {
  //   MuxedStreamInfo data = await getDownloadInfo(false);
  //   return data;
  // }

  // download(bool isAudioOnly) async {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text("Download started")));
  //   var yt = YoutubeExplode();
  //   var streamInfo = await getDownloadInfo(isAudioOnly);
  //   var stream = yt.videos.streamsClient.get(streamInfo);

  //   yt.close();
  // }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: ytControl,
          topActions: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                widget.video.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
        builder: (context, player) => Scaffold(
              backgroundColor: Colors.grey,
              body: ListView(
                children: [
                  player,
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        widget.video.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 48,
                      ))
                  // Column(
                  //   children: [
                  //     FutureBuilder(
                  //         future: getVideoInfo(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return const Center(
                  //                 child: CircularProgressIndicator());
                  //           } else if (snapshot.hasData) {
                  //             return DownloadButton(
                  //               func: download(false),
                  //               text: "Download Video",
                  //               size: snapshot.data!.size.totalMegaBytes
                  //                   .toString(),
                  //             );
                  //           } else {
                  //             return const Icon(Icons.error);
                  //           }
                  //         }),
                  //     FutureBuilder(
                  //         future: getAudioInfo(),
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState ==
                  //               ConnectionState.waiting) {
                  //             return const Center(
                  //                 child: CircularProgressIndicator());
                  //           } else if (snapshot.hasData) {
                  //             return DownloadButton(
                  //               func: download(true),
                  //               text: "Download Audio",
                  //               size: snapshot.data!.size.totalMegaBytes
                  //                   .toString(),
                  //             );
                  //           } else {
                  //             return const Icon(Icons.error);
                  //           }
                  //         }),
                  //   ],
                  // )
                ],
              ),
            ));
  }
}
