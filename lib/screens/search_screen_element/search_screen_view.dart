import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_screen_state.dart';
import 'search_screen_mutator.dart';
import 'package:clean_news_ai/ui_elements/list_element/list.dart';
import 'package:clean_news_ai/ui_elements/list_element/empty_box.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';

class SearchScreenView extends StatelessWidget{

  build(context) {
    return CupertinoTabView(
      builder: (context){
        searchMutator.getNews();
        return CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text("Search"),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 3)).then((_) {
                  searchMutator.getNews();
                });
              },
            ),
            SliverPadding(
              padding: EdgeInsets.all(2.0),
            ),
            SliverToBoxAdapter(
              child: searchWidget,
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
