import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  Animation<Color> colorAnimation;
  AnimationController colorAnimationController;
  ImageProvider<NetworkImage> image;

  @override
  void initState(){
    colorAnimationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    final Tween colorTween = ColorTween(begin: Colors.black, end: Colors.transparent);
    colorAnimation = colorTween.animate(colorAnimationController);


    image = NetworkImage("https://c1.staticflickr.com/2/1608/24154530426_3188c8c36d_b.jpg");
    image.resolve(ImageConfiguration()).addListener(_onImageLoaded);
    super.initState();
  }

  void _onImageLoaded (ImageInfo imageInfo, bool synchronousCall) {
    colorAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: AnimatedBuilder(
            animation: colorAnimation,
            builder: (_,__) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  image: AnimatedDecorationImage(
                      colorAnimation: colorAnimation,
                      fit: BoxFit.fill,
                      image: NetworkImage("https://c1.staticflickr.com/2/1608/24154530426_3188c8c36d_b.jpg")
                  ),
                ),
                child: Text("simple text", style: TextStyle(color: Colors.white),)
            ),
          ),
        ));
  }
}



class AnimatedDecorationImage extends DecorationImage{
  /// The [image], [alignment], [repeat], and [matchTextDirection] arguments
  /// must not be null.
  AnimatedDecorationImage({
    @required Animation<Color> colorAnimation,
    @required ImageProvider image,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    Rect centerSlice,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
  }) :  assert(image != null),
        assert(alignment != null),
        assert(repeat != null),
        assert(matchTextDirection != null),
        super(
          image: image,
          colorFilter: ColorFilter.mode(colorAnimation.value, BlendMode.color),
          fit: fit,
          alignment: alignment,
          centerSlice: centerSlice,
          repeat: repeat,
          matchTextDirection: matchTextDirection
      );
}