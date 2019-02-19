import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/main_screen_element/main_screen_view.dart';
import 'screens/favorites_screen_element/favorites_screen_view.dart';
import 'screens/settings_screen_element/settings_screen_view.dart';
import 'screens/search_screen_element/search_screen_view.dart';

class RootElement extends StatelessWidget{

  build(context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              const BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.time),
              ),
              const BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.search),
              ),
              const BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.bookmark),
              ),
              const BottomNavigationBarItem(
                  icon: const Icon(CupertinoIcons.gear),
              ),
            ]
        ),
        tabBuilder: (context, index) {
          switch(index){
            case 0 : {
              return mainScreenView;
            }
            case 1 : {
              return searchScreenView;
            }
            case 2 : {
              return favoritesScreenView;
            }
            case 3 : {
              return settingsScreenView;
            }
          }
        }
    );
  }
}