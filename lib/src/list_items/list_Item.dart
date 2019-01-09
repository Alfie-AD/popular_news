import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class ListItem extends StatefulWidget {

  final name;
  final url;
  var liked;
  final title;
  final publishedAt;
  final urlToImage;

  ListItem(
      this.name,
      this.url,
      this.liked,
      this.title,
      this.publishedAt,
      this.urlToImage);

  createState() => ListItemState();
}

class ListItemState extends State<ListItem> {

  build(context) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
          child: GestureDetector(
              child: Card(
                  elevation: 8.0,
                  color: Colors.transparent,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                        widget.name,
                                        style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            Share.share(widget.url);
                                          },
                                          icon: Icon(Icons.share),
                                          color: Colors.white,
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            setState(() {
                                              widget.liked = !widget.liked;
                                            });
                                          },
                                          icon: widget.liked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                              child: Text(
                                  widget.title,
                                  style: TextStyle(color: Colors.white, fontSize: 20)),
                              alignment: Alignment.center,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 16.0, bottom: 16.0, top: 8.0),
                              child: Text(widget.publishedAt,
                                  style: TextStyle(color: Colors.white, fontSize: 16)),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            image: DecorationImage(
                              image: Image.network(widget.urlToImage).image,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.hardLight),
                              fit: BoxFit.cover,
                            )
                        ),
                      )
                  )
              ),
              onTap: () => launch(widget.url)
          )
      );

  }
}

