import 'package:flutter/material.dart';
import 'root_element.dart';
import 'package:flutter/cupertino.dart';

main() => runApp(NewsApp());

class NewsApp extends StatefulWidget {

  createState() => newsAppState;
}

class NewsAppState extends State<NewsApp> {

  bool theme = true;

  build(context) {
    return MaterialApp(
      theme: theme == true ? ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan,
        primarySwatch: Colors.cyan,
        fontFamily: 'Roboto',
      ) : ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.green,
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: rootElement,
      ),
    );
  }

}

final newsAppState = NewsAppState();

