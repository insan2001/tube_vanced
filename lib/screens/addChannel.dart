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
  bool adding = false;
  bool validUrl = false;
  String hintText = "Add video url from your desired channel";

  List<Channel> newChannelList = [];

  searchChannel() {
    String userInput = controller.text;
    controller.text = "";
    if (userInput.isEmpty) return;
    setState(() {
      isProgress = true;
    });

    final regex = RegExp(regexPattern);
    if (!regex.hasMatch(userInput)) {
      setState(() {
        hintText = "Invalid url! add a video url";
        isProgress = false;
      });
    } else {
      getChannelID(userInput).then((channel) {
        newChannelList.insert(0, channel);
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
            itemBuilder: (context, index) => Card(
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
                trailing: adding
                    ? const CircularProgressIndicator()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            adding = true;
                          });
                          if (prefs.getStringList(prefKey)?.contains(
                                  newChannelList[index].id.toString()) ??
                              false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Already added this channel")));
                            setState(() {
                              isProgress = false;
                            });
                          } else {
                            getAllChannelInfo(
                                    [newChannelList[index].id.toString()],
                                    false,
                                    {})
                                .then((value) => context
                                    .read<ValueProvider>()
                                    .addValue(value[0]))
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Channel added successfully"),
                                ),
                              );
                              newChannelList.remove(newChannelList[index]);
                              setState(() {
                                newChannelList;
                                adding = false;
                              });
                            });
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
