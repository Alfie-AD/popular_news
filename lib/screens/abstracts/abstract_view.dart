import 'dart:async';
import 'package:clean_news_ai/ui_elements/empty_box.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_news_ai/ui_elements/search_bar_element/search_widget.dart';

abstract class AbstractScreenView extends StatelessWidget {
  final mutator;
  final state;
  final title;
  final isSearchScreen;
  final ScrollController scrollController = ScrollController();

  AbstractScreenView(
      this.mutator, this.title, this.state, this.isSearchScreen) {
    mutator.getNews();
  }

  build(context) {
    return CupertinoTabView(
      builder: (context) {
        return CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: isSearchScreen ? searchWidget : Text(title),
              middle: isSearchScreen ? const Text("Search") : null,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1)).then((_) {
                  mutator.getNews();
                });
              },
            ),
            StreamBuilder(
                stream: state.news,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListWidget(snapshot.data.values.toList());
                  } else {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CupertinoActivityIndicator(radius: 14.0),
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

  scrollToTop() {
    scrollController.jumpTo(0.0);
  }
}
