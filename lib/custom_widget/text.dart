import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String data;
  const MyText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data, style: const TextStyle(color: Colors.white70));
  }
}
