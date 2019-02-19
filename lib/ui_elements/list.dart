import 'package:flutter/material.dart';
import 'package:clean_news_ai/ui_elements/list_element/list_item_mutator.dart';
import 'list_element/list_item_view.dart';
import 'list_element/list_item_state.dart';

class ListWidget extends StatelessWidget{

  final values;
  final cashedItems = List(100);
  ListWidget(this.values);

  build(context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        final state = ListItemState(values[index].liked);
        if(cashedItems[index] == null){
          cashedItems[index] = ListItemView(
              values[index].source["name"],
              values[index].url,
              values[index].title,
              values[index].publishedAt,
              values[index].urlToImage,
              state,
              ListItemMutator(state)
          );
        }
        return cashedItems[index];
      },
          childCount: values.length
      ),
    );
  }
}
