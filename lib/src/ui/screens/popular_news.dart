import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class FlutterNewsScreen extends StatefulWidget {

  var articles = [];
  createState() => FlutterNewsScreenState();

}

class FlutterNewsScreenState extends State<FlutterNewsScreen> {

  initState(){
    super.initState();
    if(widget.articles.isEmpty){
      bloc.fetchAllNews();
      bloc.allNews.listen((snapshot){
        setState(() {
          widget.articles = snapshot.articles;
        });
      });
    }
  }

  build(context) {
    bloc.fetchSavedNews();
    bloc.allSavedNews.listen((snapshot){
      for(int i = 0 ; i < widget.articles.length ; i++){
        for(int j = 0 ; j < snapshot.length ; j++){
          if(widget.articles[i].url == snapshot[j]["url"]){
            setState(() {
              widget.articles[i].liked = true;
            });
          }
        }
      }
    });
    if(widget.articles.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text("Flutter news"),
        ),
        body: Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        )),
      );
    }else{
      return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              title: Text("Flutter news"),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                    widget.articles.map((article){
                      return ListItem(
                          article.source["name"],
                          article.url,
                          article.liked,
                          article.title,
                          article.publishedAt,
                          article.urlToImage
                      );
                    }).toList()
                )
            )
          ]
      );
    }
  }
}
