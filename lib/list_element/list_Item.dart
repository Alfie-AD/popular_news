import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'package:clean_news_ai/favorites_screen_element/favorites_screen_mutator.dart';
import 'package:clean_news_ai/main_screen_element/main_screen_mutator.dart';
import 'package:clean_news_ai/search_screen_element/search_screen_mutator.dart';


class ListItem extends StatefulWidget {

  final name;
  final url;
  final title;
  final publishedAt;
  final urlToImage;
  var liked;

  ListItem(
      this.name,
      this.url,
      this.title,
      this.publishedAt,
      this.urlToImage,
      this.liked);

  createState() => ListItemState();

}

class ListItemState extends State<ListItem> {

  build(context) {
    var image;
    if(widget.urlToImage != null){
      image = Image.network(widget.urlToImage).image;
    }
    return Card(
            child: Container(
                child: GestureDetector(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                      widget.name,
                                      style: const TextStyle(color: Colors.white, fontSize: 16,)),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          Share.share(widget.url);
                                        },
                                        icon: const Icon(Icons.share, color: Colors.white),
                                        color: Colors.white,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          favoritesMutator.getNews();
                                          mainMutator.updateStars(widget.url);
                                          searchMutator.updateStars(widget.url);
                                          widget.liked ? provider.deleteMyArticle(widget.url) : provider.uploadMyArticle(
                                              {
                                                "name" : widget.name,
                                                "url" : widget.url,
                                                "title" : widget.title,
                                                "publishedAt" : widget.publishedAt,
                                                "urlToImage" : widget.urlToImage,
                                                 });
                                          setState(() {
                                            widget.liked = !widget.liked;
                                          });
                                        },
                                        icon: Icon(widget.liked ? Icons.star : Icons.star_border, color: Colors.white),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                            alignment: Alignment.center,
                            child: Text(
                                widget.title,
                                style: const TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0, top: 8.0),
                            child: Text(widget.publishedAt,
                                style: const TextStyle(color: Colors.white, fontSize: 16)),
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                      decoration: image != null ? BoxDecoration(
                          color: Colors.black38,
                          image: DecorationImage(
                            image: image,
                            colorFilter: ColorFilter.mode(
                                Colors.black38,
                                BlendMode.hardLight),
                            fit: BoxFit.cover,
                          )
                      ):
                      BoxDecoration(
                          color: Colors.black38,
                      )
                    ),
                    onTap: () => launch(widget.url)
                )
            ),
          );
  }
}

