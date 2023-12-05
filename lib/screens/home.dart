import 'package:flutter/material.dart';
import 'package:youtube_clone/screens/all_channel.dart';
import 'package:youtube_clone/screens/search.dart';
import 'package:youtube_clone/screens/youtube_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  final Color selected = Colors.white70;
  final Color others = const Color.fromARGB(255, 115, 169, 214);

  late List<Widget> pages;
  late List<IconData> iconPack;

  @override
  void initState() {
    pages = [
      const YoutubehomeScreen(),
      const DisplayChannelScreen(),
      const SearchScreen(),
    ];

    iconPack = [Icons.home, Icons.groups, Icons.search];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              pages.length,
              (index) => IconButton(
                onPressed: () => setState(() {
                  pageIndex = index;
                }),
                icon: Icon(
                  iconPack[index],
                  color: pageIndex == index ? selected : others,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
