import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/saved_news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class LikedScreen extends StatefulWidget {

  createState() => LikedScreenState();

}

class LikedScreenState extends State<LikedScreen> {

  build(context) {
    bloc.fetchSavedNews();
    return StreamBuilder(
      stream: bloc.allSavedNews,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                forceElevated: true,
                title: Text("Liked"),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index){
                  return ListItem(
                    snapshot.data.values.toList()[index]["name"],
                    snapshot.data.values.toList()[index]["url"],
                    true,
                    snapshot.data.values.toList()[index]["title"],
                    snapshot.data.values.toList()[index]["publishedAt"],
                    snapshot.data.values.toList()[index]["urlToImage"],
                  );
                },
                    childCount: snapshot.data.length
                ),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green)
          ),
        );
      },
    );
  }
}