import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/src/resources/repository.dart';
import 'package:tuple/tuple.dart';
import 'package:clean_news_ai/src/ui/views/app_bar.dart';
import 'package:clean_news_ai/src/ui/views/empty_box.dart';

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

  initState(){
    _check();
    super.initState();
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
                child: _languageSelect(),
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

  _languageSelect(){
    return Column(
        children: [
          Container(
            child: RadioListTile(
              value: "ru",
              activeColor: Colors.green,
              groupValue: selectedLanguage,
              onChanged: (value) async {
                selectedLanguage = "ru";
                (await prefs).setString("lang", value);
                mainArticles.clear();
                savedArticles.clear();
                setState(() {});
              },
              title: Text(
                "Russian",
              ),
            ),
          ),
          Container(
            child: RadioListTile(
              value: "en",
              activeColor: Colors.green,
              groupValue: selectedLanguage,
              onChanged: (value) async {
                selectedLanguage = "en";
                (await prefs).setString("lang", value);
                mainArticles.clear();
                savedArticles.clear();
                setState(() {});
              },
              title: Text(
                "English",
              ),
            ),
          )
        ]
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

