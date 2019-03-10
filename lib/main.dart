import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'root_element.dart';

bool lightTheme = false;

main() async {
  final prefs = SharedPreferences.getInstance();
  lightTheme = (await prefs).getBool("t") ?? false;
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  createState() => newsAppState;
}

class NewsAppState extends State<NewsApp> {
  build(context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: lightTheme ? Brightness.light : Brightness.dark,
      ),
      home: Scaffold(
        body: RootElement(),
      ),
    );
  }
}

final newsAppState = NewsAppState();
