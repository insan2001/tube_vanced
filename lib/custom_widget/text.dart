import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String data;
  const MyText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data, style: TextStyle(color: Colors.white70));
  }
}
