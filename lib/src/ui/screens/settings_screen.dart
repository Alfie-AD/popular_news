import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/src/resources/repository.dart';

class SettingsScreen extends StatelessWidget {

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select theme:",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
            ),
            _settingsWidgets()
          ],
        ),
      ),
    );
  }

  _settingsWidgets(){
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text("Business"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "business");
              await prefs.setString("lastRequest", null);
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.flare),
            title: const Text("Science"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "science");
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.tag_faces),
            title: const Text("Entertainment"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "entertainment");
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.directions_run),
            title: const Text("Sport"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "sport");
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.healing),
            title: const Text("Health"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "health");
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.airplay),
            title: const Text("Technology"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "technology");
              clearMainNews();
            },
          ),
        ),
        Container(
          child: ListTile(
            leading: const Icon(Icons.star),
            title: const Text("General"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString("theme", "general");
              clearMainNews();
            },
          ),
        ),
      ],
    );
  }
}

