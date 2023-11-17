import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/screens/home.dart';

late SharedPreferences prefs;
String prefKey = "channelID";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  List<String> channelIdList = prefs.getStringList(prefKey) ?? [];
  if (channelIdList == []) {
    prefs.setStringList(prefKey, []);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
