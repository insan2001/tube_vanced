import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ValueProvider extends ChangeNotifier {
  Map<String, Tuple<ChannelUploadsList, Channel>> dataSet = {};
  List<Tuple<ChannelUploadsList, Channel>> channelData = [];
  bool loadingData = false;

  addValue(Tuple<ChannelUploadsList, Channel> value) {
    if (channelData.contains(value) || dataSet.containsValue(value)) return;

    String channelId = value.item2.id.toString();
    dataSet[channelId] = value;
    channelData.add(value);
    List<String> channelList = prefs.getStringList(prefKey) ?? [];
    channelList.add(channelId);
    prefs.setStringList(prefKey, channelList);
    notifyListeners();
  }

  setLoading(bool state) {
    loadingData = state;
    notifyListeners();
  }

  void sortData() {
    channelData.sort((a, b) =>
        a.item1.first.uploadDate!.compareTo(b.item1.first.uploadDate!));

    channelData = channelData.reversed.toList();
    notifyListeners();
  }

  removeValue(int index) {
    var key = channelData[index];
    var channelID = key.item2.id.toString();
    dataSet.remove(channelID);
    channelData.remove(key);
    List<String> channelList = prefs.getStringList(prefKey)!;
    channelList.remove(channelID);
    prefs.setStringList(prefKey, channelList);
    notifyListeners();
  }
}
