import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_screen_state.dart';
import 'search_screen_mutator.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/crunch.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';

class SearchScreenView extends StatelessWidget{

  SearchScreenView(){
    searchMutator.getNews();
  }

  build(context) {
    return CupertinoTabView(
      builder: (context){
        return CustomScrollView(
          /// ios BouncingScrollPhysics()
          physics: BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: searchWidget,
              middle: Text("Search"),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 3)).then((_) {
                  searchMutator.getNews();
                });
              },
            ),
            StreamBuilder(
                stream: state.news,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListWidget(snapshot.data.values.toList());
                  }else{
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    );
                  }
                }
            ),
            emptyBox
          ],
        );
      },
    );
  }
}

final searchScreenView = SearchScreenView();
