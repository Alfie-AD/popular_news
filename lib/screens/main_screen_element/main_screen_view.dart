import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_screen_mutator.dart';
import 'main_screen_state.dart';
import 'package:clean_news_ai/ui_elements/list.dart';
import 'package:clean_news_ai/ui_elements/crunch.dart';
import 'package:clean_news_ai/ui_elements/empty_box.dart';

class MainScreenView extends StatelessWidget{

  MainScreenView(){
    mainMutator.getNews();
  }

  build(context) {
    return CupertinoTabView(
      builder: (context){
        return CustomScrollView(
          /// ios BouncingScrollPhysics()
          physics: BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text("Hot news"),
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 2)).then((_) {
                  mainMutator.getNews();
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

final mainScreenView = MainScreenView();
