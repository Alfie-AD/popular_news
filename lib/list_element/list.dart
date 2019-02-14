import 'package:flutter/material.dart';
import 'list_Item.dart';


class ListWidget extends StatelessWidget{

  final values;
  const ListWidget(this.values);

  build(context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        return ListItem(
            values[index].source["name"],
            values[index].url,
            values[index].title,
            values[index].publishedAt,
            values[index].urlToImage,
            values[index].liked,
        );
      },
          childCount: values.length
      ),
    );
  }
}
