import 'package:flutter/material.dart';
import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/ui/views/app_bar.dart';
import 'package:clean_news_ai/src/ui/views/stream_builder.dart';
import 'package:clean_news_ai/src/ui/views/empty_box.dart';

class LikedScreen extends StatefulWidget {

  createState () => LikedScreenState();

}

class LikedScreenState extends State<LikedScreen> {

  build(context) {
    bloc.fetchSavedNews();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: CustomScrollView(
            slivers: [
              appBar("Liked"),
              streamBuilder(bloc.saved),
              emptyBox()
            ]
        )
    );
  }
}



