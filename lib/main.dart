import 'package:flutter/material.dart';
import 'root_element.dart';
import 'package:flutter/cupertino.dart';

main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {

  build(context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan,
        primarySwatch: Colors.cyan
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: rootElement,
      ),
    );
  }
}

final newsApp = NewsApp();

//ThemeData(
//// Define the default Brightness and Colors
//brightness: Brightness.dark,
//primaryColor: Colors.lightBlue[800],
//accentColor: Colors.cyan[600],
//
//// Define the default Font Family
//fontFamily: 'Montserrat',
//
//// Define the default TextTheme. Use this to specify the default
//// text styling for headlines, titles, bodies of text, and more.
//textTheme: TextTheme(
//headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//)
