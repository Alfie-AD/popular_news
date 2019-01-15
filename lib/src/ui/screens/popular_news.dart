import 'package:flutter/material.dart';

import 'package:clean_news_ai/src/blocs/news_bloc.dart';
import 'package:clean_news_ai/src/list_items/list_Item.dart';
import 'package:clean_news_ai/src/resources/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlutterNewsScreen extends StatefulWidget {

  createState() => FlutterNewsScreenState();

}

class FlutterNewsScreenState extends State<FlutterNewsScreen> {
  
  build(context) {
    bloc.fetchAllNews();
    return Scaffold(
        body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                forceElevated: true,
                title: Text("News"),
              ),
              _buildSearchBar(),
              StreamBuilder(
                stream: bloc.allNews,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return _buildList(snapshot.data.values.toList());
                  }else{
                    return SliverToBoxAdapter(
                      child: Container(
                        child: Center(
                          child: RefreshProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.green
                            ),
                          ),
                        ),
                      )
                    );
                  }
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 80,
                ),
              )
        ])
    );
  }

  _buildList(values){
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index){
        return ListItem(
            values[index].source["name"],
            values[index].url,
            values[index].liked,
            values[index].title,
            values[index].publishedAt,
            values[index].urlToImage,
            values[index].animated
        );
      },
          childCount: values.length
      ),
    );
  }

  _buildSearchBar(){
    return SliverPadding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Card(
            color: Colors.transparent,
            elevation: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.green,
                child: TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
                      hintText: 'Search'
                  ),
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.black54,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  controller: TextEditingController(),
                  onSubmitted: (text) async {
                    clearMainNews();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString("lastRequest", text);
                    setState(() {});
                  },
                ),
              )
            )
          )
        ]),
      ),
    );
  }
}

// another version
