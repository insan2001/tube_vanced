import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
          hideControls: false,
          disableDragSeek: true,
          doubleTapSkipTime: 10,
          enableCaption: false,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            )
          ],
        ),
        builder: (context, player) => Scaffold(
              backgroundColor: Colors.black,
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Share.share(widget.video.url);
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white70,
                        )),
                  ),
                ],
              ),
            ));
  }
}
