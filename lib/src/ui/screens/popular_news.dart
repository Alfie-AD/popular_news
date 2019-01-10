import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class FlutterNewsScreen extends StatelessWidget {

  build(context) {
    bloc.fetchAllNews();
    return StreamBuilder(
      stream: bloc.allNews,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return _buidList(snapshot.data.values.toList());
        }
        return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green)
          ),
        );
      },
    );
  }

  _buidList(values){
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          forceElevated: true,
          title: Text("News"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index){
            return ListItem(
              values[index].source["name"],
              values[index].url,
              values[index].liked,
              values[index].title,
              values[index].publishedAt,
              values[index].urlToImage,
            );
          },
              childCount: values.length
          ),
        )
      ],
    );
  }
}
