import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/src/resources/repository.dart';
import 'package:tuple/tuple.dart';
import 'package:clean_news_ai/src/ui/views/app_bar.dart';
import 'package:clean_news_ai/src/ui/views/list_items/empty_box.dart';

class SettingsScreen extends StatefulWidget {

  createState() => SettingsState();

}

class SettingsState extends State<SettingsScreen>{

  String selectedTheme;
  String selectedLanguage;
  final prefs = SharedPreferences.getInstance();

  final settingsItems = [
    Tuple2("Business", Icons.attach_money),
    Tuple2("Science", Icons.flare),
    Tuple2("Entertainment", Icons.tag_faces),
    Tuple2("Sport", Icons.directions_run),
    Tuple2("Health", Icons.healing),
    Tuple2("Technology", Icons.airplay),
    Tuple2("General", Icons.star),
  ];

  final settingsLanguage = [
    Tuple2("Russian", "ru"),
    Tuple2("English", "en"),
    Tuple2("Chinese", "cn"),
    Tuple2("Deutsch", "de"),
    Tuple2("French", "fr"),
    Tuple2("Japanese", "jp"),
  ];

  initState(){
    super.initState();
    _check();
  }

  build(context){
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: CustomScrollView(
            slivers: [
              appBar("Settings"),
              SliverToBoxAdapter(
                child: _settingsWidgets(),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverToBoxAdapter(
                child: _languageWidgets(),
              ),
              emptyBox()
            ]
        )
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
                (await prefs).setString("theme", value.toLowerCase());
                (await prefs).setString("lastRequest", null);
                mainArticles.clear();
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

  _languageWidgets() {
    return Column(
        children: settingsLanguage.map((tuple){
          return Container(
            child: RadioListTile(
              value: tuple.item2,
              activeColor: Colors.green,
              groupValue: selectedLanguage,
              onChanged: (value) async {
                selectedLanguage = tuple.item2;
                (await prefs).setString("lang", value);
                mainArticles.clear();
                setState(() {});
              },
              title: Text(
                tuple.item1,
              ),
            ),
          );
        }).toList()
    );
  }

  _check() async {
    if((await prefs).getString("theme") != null){
      selectedTheme = (await prefs).getString("theme")[0].toUpperCase() + (await prefs).getString("theme").substring(1);
      setState(() {});
    }
    if((await prefs).getString("lang") != null){
      selectedLanguage = (await prefs).getString("lang");
      setState(() {});
    }else{
      selectedLanguage = "en";
      setState(() {});
    }
  }

}

