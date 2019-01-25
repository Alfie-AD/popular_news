import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/ui/views/list_items/list_Item.dart';

buildList(values){
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index){
      return ListItem(
          values[index].source["name"],
          values[index].url,
          values[index].liked,
          values[index].title,
          values[index].publishedAt,
          values[index].urlToImage,
          values[index].animated
      );
    },
        childCount: values.length
    ),
  );
  //}
}