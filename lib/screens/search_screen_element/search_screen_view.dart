import 'dart:async';

import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'search_screen_mutator.dart';
import 'search_screen_state.dart';

class SearchScreenView extends StatelessWidget {
  SearchScreenView() {
    searchMutator.getNews();
  }

  build(context) {
    return CupertinoTabView(
      builder: (context) {
        return CustomScrollView(
          /// ios BouncingScrollPhysics()
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: searchWidget,
              middle: const Text("Search"),
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
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListWidget(snapshot.data.values.toList());
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: const CupertinoActivityIndicator(),
                        ),
                      ),
                    );
                  }
                }),
            emptyBox
          ],
        );
      },
    );
  }
}

final searchScreenView = SearchScreenView();
