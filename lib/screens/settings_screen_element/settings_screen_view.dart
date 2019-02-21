
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_mutator.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/crunch.dart';


/// This widget is't done yet!
class SettingsScreenView extends StatefulWidget {
  bool selectedColorTheme = true;
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
    const Tuple2("Mixed", Icons.bubble_chart),
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
          /// ios BouncingScrollPhysics()
          physics: BouncingScrollPhysics(),
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text("Settings"),
              ),
              SliverToBoxAdapter(
                child: _themesWidgets(),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverToBoxAdapter(
                child: _languageWidgets(),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              emptyBox
            ]
        )
    );
  }

  _themesWidgets() {
    return Column(
        children: settingsItems.map((tuple){
          return Container(
            child: RadioListTile(
              value: tuple.item1,
              groupValue: selectedTheme,
              onChanged: (value) async {
                selectedTheme = tuple.item1;
                value != "Mixed" ?
                (await prefs).setString("theme", value.toLowerCase()) :
                (await prefs).setString("theme", null);
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

  _languageWidgets() {
    return Column(
        children: settingsLanguage.map((tuple){
          return Container(
            child: RadioListTile(
              value: tuple.item2,
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
    selectedLanguage = (await prefs).getString("lang") ?? "en";
    setState(() {});
    if((await prefs).getString("theme") != null){
      selectedTheme = (await prefs).getString("theme")[0].toUpperCase() + (await prefs).getString("theme").substring(1);
      setState(() {});
    }else{
      selectedTheme = "Mixed";
      setState(() {});
    }
  }

}

final settingsScreenView = SettingsScreenView();
