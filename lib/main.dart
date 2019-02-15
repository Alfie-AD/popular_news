import 'package:flutter/material.dart';
import 'root_element.dart';
import 'package:flutter/cupertino.dart';

main() => runApp(newsApp);

class NewsApp extends StatefulWidget {

  bool theme = true;

  createState() => newsAppState;
}

class NewsAppState extends State<NewsApp> {

  build(context) {
    return MaterialApp(
      theme: widget.theme == true ? ThemeData(
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

final newsApp = NewsApp();
final newsAppState = NewsAppState();

