import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/models/Item_model.dart';
import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';

class MovieList extends StatelessWidget {

  build(context) {
    bloc.fetchAllNews();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular News'),
      ),
      body: StreamBuilder(
        stream: bloc.allNews,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(
              snapshot.data.articles[index].source["name"],
              snapshot.data.articles[index].url,
              false,
              snapshot.data.articles[index].title,
              snapshot.data.articles[index].publishedAt,
              snapshot.data.articles[index].urlToImage
          );
        });
  }
}
