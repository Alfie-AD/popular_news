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

//class StaggerDemo extends StatefulWidget {
//  @override
//  _StaggerDemoState createState() => _StaggerDemoState();
//}
//
//class _StaggerDemoState extends State<StaggerDemo> with TickerProviderStateMixin {
//  AnimationController _controller;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _controller = AnimationController(
//        duration: const Duration(milliseconds: 2000),
//        vsync: this
//    );
//  }
//
//  // ...Boilerplate...
//
//  Future<void> _playAnimation() async {
//    try {
//      await _controller.forward().orCancel;
//      await _controller.reverse().orCancel;
//    } on TickerCanceled {
//      // the animation got canceled, probably because we were disposed
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    timeDilation = 10.0; // 1.0 is normal animation speed.
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Staggered Animation'),
//      ),
//      body: GestureDetector(
//        behavior: HitTestBehavior.opaque,
//        onTap: () {
//          _playAnimation();
//        },
//        child: Center(
//          child: Container(
//            width: 300.0,
//            height: 300.0,
//            decoration: BoxDecoration(
//              color: Colors.black.withOpacity(0.1),
//              border: Border.all(
//                color:  Colors.black.withOpacity(0.5),
//              ),
//            ),
//            child: StaggerAnimation(
//                controller: _controller.view
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//class StaggerAnimation extends StatelessWidget {
//  StaggerAnimation({ Key key, this.controller, this.width, this.height, this.padding, this.borderRadius, this.color }) :
//
//  // Each animation defined here transforms its value during the subset
//  // of the controller's duration defined by the animation's interval.
//  // For example the opacity animation transforms its value during
//  // the first 10% of the controller's duration.
//
//        opacity = Tween<double>(
//          begin: 0.0,
//          end: 1.0,
//        ).animate(
//          CurvedAnimation(
//            parent: controller,
//            curve: Interval(
//              0.0, 0.100,
//              curve: Curves.ease,
//            ),
//          ),
//        ),
//
//  // ... Other tween definitions ...
//
//        super(key: key);
//
//  final Animation<double> controller;
//  final Animation<double> opacity;
//  final Animation<double> width;
//  final Animation<double> height;
//  final Animation<EdgeInsets> padding;
//  final Animation<BorderRadius> borderRadius;
//  final Animation<Color> color;
//
//  // This function is called each time the controller "ticks" a new frame.
//  // When it runs, all of the animation's values will have been
//  // updated to reflect the controller's current value.
//  Widget _buildAnimation(BuildContext context, Widget child) {
//    return Container(
//      padding: padding.value,
//      alignment: Alignment.bottomCenter,
//      child: Opacity(
//        opacity: opacity.value,
//        child: Container(
//          width: width.value,
//          height: height.value,
//          decoration: BoxDecoration(
//            color: color.value,
//            border: Border.all(
//              color: Colors.indigo[300],
//              width: 3.0,
//            ),
//            borderRadius: borderRadius.value,
//          ),
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      builder: _buildAnimation,
//      animation: controller,
//    );
//  }
//}







//
//class AnimatedListItem extends StatefulWidget {
//  final name;
//  final url;
//  final title;
//  final publishedAt;
//  final urlToImage;
//  final state;
//  final mutator;
//
//  const AnimatedListItem(this.name, this.url, this.title, this.publishedAt, this.urlToImage, this.state, this.mutator);
//  createState() => AnimatedListItemState();
//}
//
//class AnimatedListItemState extends State<AnimatedListItem> with SingleTickerProviderStateMixin {
//
//  Animation<double> animation;
//  AnimationController controller;
//
//  initState() {
//    super.initState();
//    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
//    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
//    controller.forward();
//  }
//
//  build(context) {
//    return AnimatedTwo(widget.name, widget.url, widget.title, widget.publishedAt, widget.urlToImage, widget.state, widget.mutator, animation: animation,);
//  }
//
//}
//
//class AnimatedTwo extends AnimatedWidget {
//  final name;
//  final url;
//  final title;
//  final publishedAt;
//  final urlToImage;
//  final state;
//  final mutator;
//  final _sizeTween = Tween<double>(begin: 0, end: 500);
//
//
//  AnimatedTwo(this.name, this.url, this.title, this.publishedAt, this.urlToImage, this.state, this.mutator,  {Key key, Animation<double> animation})
//      : super(key: key, listenable: animation);
//
//  build(context) {
//    final Animation<double> animation = listenable;
//
//    return StreamBuilder(
//      stream: state.imageStream,
//      builder: (context, value){
//        return GestureDetector(
//          onTap: (){
//            launch(url);
//          },
//          child: Card(
//            child: Container(
//              // height: _sizeTween.evaluate(animation),
//              width: _sizeTween.evaluate(animation),
//              decoration: BoxDecoration(
//                  color: Colors.grey[900],
//                  image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: value.data ?? state.cashedImage,
//                      colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.hardLight)
//                  )
//              ),
//              child: Column(
//                children: [
//                  Container(
//                    padding: const EdgeInsets.only(left: 16.0, right: 4.0),
//                    alignment: Alignment.centerRight,
//                    child: Row(
//                      children: [
//                        Expanded(child: Text(
//                            name, style: const TextStyle(color: CupertinoColors.white))
//                        ),
//                        Row(
//                          children: [
//                            IconButton(
//                              icon: const Icon(CupertinoIcons.reply),
//                              onPressed: () async {
//                                Share.share(url);
//                              },
//                            ),
//                            IconButton(
//                              icon: Icon(state.liked ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark),
//                              onPressed: () async {
//                                state.liked ? provider.deleteMyArticle(url) : provider.uploadMyArticle(
//                                    {
//                                      "name" : name,
//                                      "url" : url,
//                                      "title" : title,
//                                      "publishedAt" : publishedAt,
//                                      "urlToImage" : urlToImage,
//                                    });
//                                favoritesMutator.getNews();
//                                mainMutator.updateStars(url);
//                                searchMutator.updateStars(url);
//                              },
//                            ),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                  Container(
//                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                    alignment: Alignment.centerLeft,
//                    child: Text(title, style: const TextStyle(color: CupertinoColors.white, fontSize: 20)),
//                  ),
//                  Container(
//                    padding: const EdgeInsets.all(16.0),
//                    alignment: Alignment.centerRight,
//                    child: Text(publishedAt, style: const TextStyle(color: CupertinoColors.white, fontSize: 16)),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}