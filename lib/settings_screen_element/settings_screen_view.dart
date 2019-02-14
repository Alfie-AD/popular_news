
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:clean_news_ai/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/list_element/empty_box.dart';

class SettingsScreenView extends StatefulWidget {

  createState() => SettingsState();

}

class SettingsState extends State<SettingsScreenView>{

  String selectedTheme;
  String selectedLanguage;
  final prefs = SharedPreferences.getInstance();

  final settingsItems = [
    const Tuple2("Business", Icons.attach_money),
    const Tuple2("Science", Icons.flare),
    const Tuple2("Entertainment", Icons.tag_faces),
    const Tuple2("Sport", Icons.directions_run),
    const Tuple2("Health", Icons.healing),
    const Tuple2("Technology", Icons.airplay),
    const Tuple2("General", Icons.star),
  ];

  final settingsLanguage = [
    const Tuple2("Russian", "ru"),
    const Tuple2("English", "en"),
    const Tuple2("Chinese", "cn"),
    const Tuple2("Deutsch", "de"),
    const Tuple2("French", "fr"),
    const Tuple2("Japanese", "jp"),
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
              CupertinoSliverNavigationBar(
                largeTitle: const Text("Settings"),
              ),
              SliverToBoxAdapter(
                child: _settingsWidgets(),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverToBoxAdapter(
                child: _languageWidgets(),
              ),
              emptyBox
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
              activeColor: Colors.cyan,
              groupValue: selectedTheme,
              onChanged: (value) async {
                selectedTheme = tuple.item1;
                (await prefs).setString("theme", value.toLowerCase());
                (await prefs).setString("lastRequest", null);
                mainMutator.getNews();
                setState(() {});
              },
              secondary: Icon(tuple.item2, color: Colors.cyan),
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
              activeColor: Colors.cyan,
              groupValue: selectedLanguage,
              onChanged: (value) async {
                selectedLanguage = tuple.item2;
                (await prefs).setString("lang", value);
                mainMutator.getNews();
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

final settingsScreenView = SettingsScreenView();

