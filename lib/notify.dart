import 'package:flutter/material.dart';
import 'package:youtube_clone/functions/linkedList.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ValueProvider extends ChangeNotifier {
  Map<String, Tuple<ChannelUploadsList, Channel>> dataSet = {};

  List<Tuple<ChannelUploadsList, Channel>> channelData = [];

  addValue(Channel key, Tuple<ChannelUploadsList, Channel> value) async {
    dataSet[key.id.toString()] = value;
    channelData.add(value);
    List<String> channelList = [];
    for (var element in channelData) {
      channelList.add(element.item2.id.toString());
    }
    await prefs.setStringList(prefKey, channelList);
    notifyListeners();
  }

  removeValue(Tuple<ChannelUploadsList, Channel> key) async {
    dataSet.remove(key.item2.id.toString());
    channelData.remove(key);
    List<String> channelList = [];
    for (var element in channelData) {
      channelList.add(element.item2.id.toString());
    }
    await prefs.setStringList(prefKey, channelList);
    notifyListeners();
  }
}
