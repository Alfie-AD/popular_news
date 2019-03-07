import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:clean_news_ai/screens/favorites_screen_element/favorites_screen_mutator.dart';
import 'package:clean_news_ai/screens/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/screens/search_screen_element/search_screen_mutator.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'dart:ui';

class ListItemView extends StatelessWidget {

  final name;
  final url;
  final title;
  final publishedAt;
  final urlToImage;
  final state;
  final mutator;

  ListItemView(
      this.name,
      this.url,
      this.title,
      this.publishedAt,
      this.urlToImage,
      this.state,
      this.mutator)
  {
    mutator.downloadImage(urlToImage);
  }

  build(context) {
    return StreamBuilder(
      stream: state.imageStream,
      builder: (context, value){
        return GestureDetector(
          onTap: (){
            launch(url);},
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: value.data ?? state.cashedImage,
                      colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.hardLight)
                  )
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Expanded(child: Text(
                            name, style: const TextStyle(color: CupertinoColors.white))
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(CupertinoIcons.reply),
                              onPressed: () async {
                                Share.share(url);},
                            ),
                            IconButton(
                              icon: Icon(state.liked ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark),
                              onPressed: () async {
                                state.liked ? provider.deleteMyArticle(url) : provider.uploadMyArticle(
                                    {
                                      "name" : name,
                                      "url" : url,
                                      "title" : title,
                                      "publishedAt" : publishedAt,
                                      "urlToImage" : urlToImage,
                                    });
                                favoritesMutator.getNews();
                                mainMutator.updateStars(url);
                                searchMutator.updateStars(url);},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(title, style: const TextStyle(color: CupertinoColors.white, fontSize: 20)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerRight,
                    child: Text(publishedAt, style: const TextStyle(color: CupertinoColors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        );
        },
    );
  }
}
