import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/resources/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

searchBar(action){
  return SliverPadding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    sliver: SliverList(
      delegate: SliverChildListDelegate([
        Card(
            color: Colors.transparent,
            elevation: 8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.green
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
                    hintText: 'Search'
                ),
                textInputAction: TextInputAction.search,
                cursorColor: Colors.black54,
                style: TextStyle(fontSize: 18, color: Colors.black54),
                onSubmitted: (text) async {
                  mainArticles.clear();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString("lastRequest", text);
                  action();
                },
              ),
            )
        )
      ]),
    ),
  );
}