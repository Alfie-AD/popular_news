import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class LikedScreen extends StatefulWidget {

  var articles = [];
  createState() => LikedScreenState();

}

class LikedScreenState extends State<LikedScreen> {

  initState(){
    super.initState();

  }

  build(context) {
    bloc.fetchSavedNews();
    bloc.allSavedNews.listen((snapshot){
      setState(() {
        widget.articles = snapshot;
      });
    });
      return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              title: Text("Liked"),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                    widget.articles.map((article){
                      return ListItem(
                          article["name"],
                          article["url"],
                          true,
                          article["title"],
                          article["publishedAt"],
                          article["urlToImage"]
                      );
                    }).toList()
                )
            )
          ]
      );
    }

}




//    StreamBuilder(
//      stream: bloc.allNews,
//      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
//        if (snapshot.hasData) {
//          return buildList(snapshot);
//        } else if (snapshot.hasError) {
//          return Text(snapshot.error.toString());
//        }
//        return Center(child: CircularProgressIndicator());
//      },
//    );