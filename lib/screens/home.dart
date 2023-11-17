import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/addChannel.dart';
import 'package:youtube_clone/screens/allChannel.dart';
import 'package:youtube_clone/screens/load.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final Color selected = Colors.white;
  final Color others = Colors.blue;

  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      const LoadingScreen(),
      const DisplayChannelScreen(),
      const AddChannelScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: Icon(
                Icons.home_rounded,
                color: pageIndex == 0 ? selected : others,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: Icon(
                Icons.person_pin,
                color: pageIndex == 1 ? selected : others,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: Icon(
                Icons.add_box_sharp,
                color: pageIndex == 2 ? selected : others,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
