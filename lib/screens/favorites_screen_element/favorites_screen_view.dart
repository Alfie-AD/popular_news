import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'favorites_screen_mutator.dart';
import 'favorites_screen_state.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';

class FavoritesScreenView extends StatelessWidget{

  build(context) {
    favoritesMutator.getNews();
    return CupertinoTabView(
      builder: (context){
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text("Favorites"),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 3)).then((_) {
                  favoritesMutator.getNews();
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

final favoritesScreenView = FavoritesScreenView();
