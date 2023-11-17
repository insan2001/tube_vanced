import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/constants.dart';
import 'package:youtube_clone/functions/youtube.dart';
import 'package:youtube_clone/main.dart';
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
  Widget display = Container();

  List<Channel> newChannelList = [];

  addChannel(String channelID) {
    channelIdList.add(channelID);
    prefs.setStringList(prefKey, channelIdList).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Channel added successfully"),
        ),
      );
    });
  }

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
        display = const Text("Url Not Valid");
        isProgress = false;
      });
      return;
    }

    getChannelID(userInput).then((channel) {
      var channelID = channel.id.toString();
      if (channelIdList.contains(channelID)) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Already added this channel")));
        setState(() {
          isProgress = false;
        });
      } else {
        newChannelList.insert(0, channel);
        setState(() {
          isProgress = false;

          display = ListView.builder(
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
                trailing: IconButton(
                  onPressed: () {
                    addChannel(channelID);
                    setState(() {
                      newChannelList.remove(channel);
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
          );
        });
      }
    });
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
                  hintText: "Add video url",
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
          child: display,
        )
      ],
    );
  }
}
