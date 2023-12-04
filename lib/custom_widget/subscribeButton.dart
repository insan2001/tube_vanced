import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/main.dart';
import 'package:youtube_clone/notify.dart';

class SubscribeButton extends StatefulWidget {
  final String channelId;
  const SubscribeButton({super.key, required this.channelId});

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  late bool _isSubscribed;

  @override
  void initState() {
    List<String> storedChannels = prefs.getStringList(prefKey) ?? [];

    if (storedChannels.contains(widget.channelId)) {
      _isSubscribed = true;
    } else {
      _isSubscribed = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: TextButton(
        onPressed: () {
          // handle subscribe and unsubsribe
          // if subscribed remove else add
          if (_isSubscribed) {
            context.read<ValueProvider>().unSubscribe(widget.channelId);
          } else {
            context.read<ValueProvider>().subscribe(widget.channelId);
          }
          setState(() {
            _isSubscribed = !_isSubscribed;
          });
        },
        child: Card(
          color: _isSubscribed ? Colors.grey : Colors.red,
          elevation: 10,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_isSubscribed ? "Subscribed" : "Subscribe"),
          )),
        ),
      ),
    );
  }
}
