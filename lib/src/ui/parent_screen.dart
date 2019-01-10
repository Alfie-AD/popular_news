import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/ui/screens/popular_news.dart';
import 'package:clean_news_ai/src/ui/screens/liked_screen.dart';
import 'package:clean_news_ai/src/ui/screens/settings_screen.dart';
import 'dart:ui';

class ParentScreen extends StatefulWidget{

  createState() => ParentScreenState();

}

class ParentScreenState extends State<ParentScreen> with SingleTickerProviderStateMixin{

  TabController tabController;

  initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  getTabBar(){
    return Container(
      color: Colors.black54,
      child: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.whatshot, color: Colors.green),
          ),
          Tab(
            icon: Icon(Icons.favorite_border, color: Colors.green),

          ),
          Tab(
            icon: Icon(Icons.settings, color: Colors.green),
          )
        ],
        controller: tabController,
        indicatorColor: Colors.green,
      ),
    );
  }

  getTabBarViews(var tabs){
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  build(context) {
    return Scaffold(
      body: Stack(
          children: [
            getTabBarViews([
              FlutterNewsScreen(),
              LikedScreen(),
              SettingsScreen()
            ]),
            Container(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
                  child: getTabBar()),
              alignment: AlignmentDirectional.bottomEnd,
            )
          ]
      ),
    );
  }
}