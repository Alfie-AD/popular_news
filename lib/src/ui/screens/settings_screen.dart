import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/src/resources/repository.dart';
import 'package:tuple/tuple.dart';

class SettingsScreen extends StatefulWidget {

  createState() => SettingsState();

}

class SettingsState extends State<SettingsScreen>{

  String selectedTheme;

  final settingsItems = [
    Tuple2("Business", Icons.attach_money),
    Tuple2("Science", Icons.flare),
    Tuple2("Entertainment", Icons.tag_faces),
    Tuple2("Sport", Icons.directions_run),
    Tuple2("Health", Icons.healing),
    Tuple2("Technology", Icons.airplay),
    Tuple2("General", Icons.star),
  ];

  build(context) {
    _check();
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
                "Selected theme: $selectedTheme",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            _settingsWidgets()
          ],
        ),
      ),
    );
  }

  _settingsWidgets() {
    return Column(
        children: settingsItems.map((tuple){
          return Container(
            child: ListTile(
              leading: Icon(tuple.item2, color: Colors.green),
              title: Text(
                tuple.item1,
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString("theme", tuple.item1.toLowerCase());
                await prefs.setString("lastRequest", null);
                mainArticles.clear();
              },
            ),
          );
        }).toList()
    );
  }

  _check() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedTheme = prefs.getString("theme") ?? "nothing";
    });
  }
}

