import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/saved_news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class LikedScreen extends StatelessWidget {

  build(context) {
    bloc.fetchSavedNews();
    return Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                forceElevated: true,
                title: Text("Liked"),
              ),
              StreamBuilder(
                stream: bloc.allSavedNews,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return _buildList(snapshot.data.values.toList());
                  }else{
                    return SliverToBoxAdapter();
                  }
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 80,
                ),
              )
            ])
    );
  }

  _buildList(values){
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        return ListItem(
          values.toList()[index]["name"],
          values.toList()[index]["url"],
          true,
          values.toList()[index]["title"],
          values.toList()[index]["publishedAt"],
          values.toList()[index]["urlToImage"],
        );
      },
          childCount: values.length
      ),
    );
  }
}



