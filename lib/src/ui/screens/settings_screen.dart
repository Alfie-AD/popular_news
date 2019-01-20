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
        child: Column(
          children: <Widget>[
            _settingsWidgets(),
            Divider()
          ],
        ),
      ),
    );
  }

  _settingsWidgets() {
    return Column(
        children: settingsItems.map((tuple){
          return Container(
            child: RadioListTile(
                value: tuple.item1,
                activeColor: Colors.green,
                groupValue: selectedTheme,
                onChanged: (value) async {
                  selectedTheme = tuple.item1;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString("theme", value.toLowerCase());
                  await prefs.setString("lastRequest", null);
                  mainArticles.clear();
                  savedArticles.clear();
                  setState(() {});
                },
             secondary: Icon(tuple.item2, color: Colors.green),
              title: Text(
                tuple.item1,
              ),
            ),
          );
        }).toList()
    );
  }

  _check() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("theme") != null){
      setState(() {
        selectedTheme = prefs.getString("theme")[0].toUpperCase() + prefs.getString("theme").substring(1);
      });
    }
  }
}

