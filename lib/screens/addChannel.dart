import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/constants.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/notify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AddChannelScreen extends StatefulWidget {
  const AddChannelScreen({super.key});

  @override
  State<AddChannelScreen> createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  TextEditingController controller = TextEditingController();
  late List<String> channelIdList;
  bool isProgress = false;

  bool validUrl = false;
  String hintText = "Add video url from your desired channel";

  List<Channel> newChannelList = [];
  List<bool> newChannelProgress = [];

  searchChannel() {
    Provider.of<ValueProvider>(context, listen: false).setLoading(true);
    String userInput = controller.text;
    controller.text = "";
    if (userInput.isEmpty) return;
    setState(() {
      isProgress = true;
    });

    final regex = RegExp(regexPattern);
    if (!regex.hasMatch(userInput)) {
      Provider.of<ValueProvider>(context, listen: false).setLoading(false);
      setState(() {
        hintText = "Invalid url! add a video url";
        isProgress = false;
      });
    } else {
      getChannel(userInput).then((channel) {
        newChannelProgress.insert(0, false);
        newChannelList.insert(0, channel);
        Provider.of<ValueProvider>(context, listen: false).setLoading(false);
        setState(() {
          hintText = "Add video url from your desired channel";
          newChannelList;
          isProgress = false;
        });
      });
    }
  }

  @override
  void initState() {
    channelIdList = prefs.getStringList(prefKey) ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.black),
                  suffixIcon: isProgress
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: searchChannel,
                          icon: const Icon(Icons.search)),
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: ListView.builder(
              itemCount: newChannelList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey,
                  child: ListTile(
                    leading: CircleAvatar(
                      maxRadius: 30,
                      foregroundImage: CachedNetworkImageProvider(
                        newChannelList[index].logoUrl,
                      ),
                    ),
                    title: Text(newChannelList[index].title),
                    subtitle: Text(
                        "${newChannelList[index].subscribersCount} Subscribers"),
                    trailing: newChannelProgress[index]
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                newChannelProgress[index] = true;
                              });
                              if (prefs.getStringList(prefKey)?.contains(
                                      newChannelList[index].id.toString()) ??
                                  false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Already added this channel")));
                                setState(() {
                                  newChannelProgress[index] = false;
                                });
                              } else {
                                Provider.of<ValueProvider>(context,
                                        listen: false)
                                    .setLoading(true);
                                getChannelInfo(
                                        newChannelList[index].id.toString())
                                    .then((value) {
                                  Provider.of<ValueProvider>(context,
                                          listen: false)
                                      .addValue(value);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Channel added successfully"),
                                    ),
                                  );
                                }).then((value) {
                                  newChannelList.remove(newChannelList[index]);
                                  Provider.of<ValueProvider>(context,
                                          listen: false)
                                      .setLoading(false);
                                  setState(() {
                                    newChannelList;
                                    newChannelProgress[index] = false;
                                  });
                                });
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
