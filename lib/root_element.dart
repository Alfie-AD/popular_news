import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_screen_element/main_screen_view.dart';
import 'favorites_screen_element/favorites_screen_view.dart';
import 'settings_screen_element/settings_screen_view.dart';
import 'search_screen_element/search_screen_view.dart';

class RootElement extends StatelessWidget{

  build(context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.whatshot),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.star),
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
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

final rootElement = RootElement();