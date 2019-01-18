import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/ui/views/app_bar.dart';
import 'package:clean_news_ai/src/ui/views/stream_builder.dart';
import 'package:clean_news_ai/src/ui/views/empty_box.dart';
import 'package:clean_news_ai/src/ui/views/search_bar.dart';

class FlutterNewsScreen extends StatefulWidget {

  createState() => FlutterNewsScreenState();

}

class FlutterNewsScreenState extends State<FlutterNewsScreen> {
  
  build(context) {
    bloc.fetchAllNews();
    return Scaffold(
        body: CustomScrollView(
            slivers: [
              appBar("News"),
              searchBar((){
                setState(() {});
              }),
              streamBuilder(bloc.news),
              emptyBox()
            ]
        )
    );
  }
}
