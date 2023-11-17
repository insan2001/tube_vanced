import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final String text;
  final String size;
  final Function func;
  const DownloadButton(
      {super.key, required this.text, required this.size, required this.func});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func(),
      child: Container(
        width: 160,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text(text), Icon(Icons.download)],
            ),
            Text(size),
          ],
        ),
      ),
    );
  }
}
