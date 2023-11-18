import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ValueProvider extends ChangeNotifier {
  Map<String, Tuple<ChannelUploadsList, Channel>> dataSet = {};
  List<Tuple<ChannelUploadsList, Channel>> channelData = [];

  addValue(Tuple<ChannelUploadsList, Channel> value) {
    if (channelData.contains(value)) return;
    String channelId = value.item2.id.toString();
    dataSet[channelId] = value;
    channelData.add(value);
    List<String> channelList = prefs.getStringList(prefKey) ?? [];
    channelList.add(channelId);
    prefs.setStringList(prefKey, channelList);
    print(channelData);
    notifyListeners();
  }

  void sortData() {
    channelData.sort((a, b) =>
        a.item1.first.uploadDate!.compareTo(b.item1.first.uploadDate!));

    channelData = channelData.reversed.toList();
    notifyListeners();
  }

  removeValue(int index) {
    print("index $index");
    var key = channelData[index];
    var channelID = key.item2.id.toString();
    dataSet.remove(channelID);
    channelData.remove(key);
    List<String> channelList = prefs.getStringList(prefKey)!;
    print("channel list $channelList");
    channelList.remove(channelID);
    print("channel list $channelList");
    prefs.setStringList(prefKey, channelList);
    notifyListeners();
  }
}
