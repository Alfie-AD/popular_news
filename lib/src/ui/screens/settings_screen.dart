import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/app.dart';

class SettingsScreen extends StatefulWidget {

  createState() => SettingsScreenState();

}

class SettingsScreenState extends State<SettingsScreen> {

  build(context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
      );
    }
  }

