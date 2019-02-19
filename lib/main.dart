import 'package:flutter/material.dart';
import 'root_element.dart';
import 'package:flutter/cupertino.dart';

main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  build(context) {
    return MaterialApp(
      theme: ThemeData(
        toggleableActiveColor: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: RootElement(),
      ),
    );
  }
}


