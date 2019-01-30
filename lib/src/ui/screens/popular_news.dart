import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/ui/views/app_bar.dart';
import 'package:clean_news_ai/src/ui/views/stream_builder.dart';
import 'package:clean_news_ai/src/ui/views/list_items/empty_box.dart';
import 'package:clean_news_ai/src/ui/views/search_bar.dart';
import 'dart:async';


class FlutterNewsScreen extends StatefulWidget {

  var scrollPosition = 0.0;

  createState() => FlutterNewsScreenState();

}

class FlutterNewsScreenState extends State<FlutterNewsScreen> {

  var _controller = ScrollController();

  initState(){
    _controller.addListener(_scrollListener);
    Timer(Duration(milliseconds: 1), (){
      _controller.animateTo(widget.scrollPosition, duration: Duration(milliseconds: 150), curve: Curves.linear);
    });
    super.initState();
  }

  _scrollListener(){
    widget.scrollPosition = _controller.offset;
  }


  build(context) {
    bloc.fetchAllNews();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: CustomScrollView(
          controller: _controller,
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
