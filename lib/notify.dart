import 'package:flutter/material.dart';

import 'package:youtube_clone/main.dart';

class ValueProvider extends ChangeNotifier {
  List<String> myChannels =
      prefs.getStringList(prefKey) ?? []; //this contains subsribed channel ids

  void subscribe(String channelId) {
    myChannels.add(channelId);
    prefs.setStringList(prefKey, myChannels).then((_) {
      notifyListeners();
    });
  }

  void unSubscribe(String channelId) {
    myChannels.remove(channelId);
    prefs.setStringList(prefKey, myChannels).then((_) {
      notifyListeners();
    });
  }
}
