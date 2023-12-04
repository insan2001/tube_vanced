import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SubscribeButton extends StatefulWidget {
  final Channel channel;
  const SubscribeButton({super.key, required this.channel});

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  late bool _isSubscribed;

  @override
  void initState() {
    // check for channel in subscribed list
    _isSubscribed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // handle subscribe and unsubsribe
        // if subscribed remove else add
        setState(() {
          _isSubscribed = !_isSubscribed;
        });
      },
      child: Card(
        color: !_isSubscribed ? Colors.grey : Colors.red,
        elevation: 10,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_isSubscribed ? "Subscribe" : "Subscribed"),
        )),
      ),
    );
  }
}
