import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/ui/views/list.dart';

streamBuilder(stream){
  return StreamBuilder(
    stream: stream,
    builder: (context, snapshot) {
      if(snapshot.hasData){
        return buildList(snapshot.data.values.toList());
      }else{
        return SliverToBoxAdapter(
          child: Center(
            child: RefreshProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          ),
        );
      }
    },
  );
}