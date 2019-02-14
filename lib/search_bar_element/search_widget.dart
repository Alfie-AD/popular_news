import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/search_screen_element/search_screen_mutator.dart';

class SearchWidget extends StatelessWidget {

  final textController = TextEditingController();

  build(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.inactiveGray,
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 40.0,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: "Roboto",
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(icon: Icon(Icons.cancel), onPressed: (){
                textController.clear();
              }),
              border: InputBorder.none),
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Roboto",
          ),
          onSubmitted: (value) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("lastRequest", value);
            searchMutator.getNews();
          },
        ),
      )
    );
  }
}

final searchWidget = SearchWidget();