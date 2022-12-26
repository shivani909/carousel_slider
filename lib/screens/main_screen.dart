import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:show_up_animation/show_up_animation.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> with TickerProviderStateMixin {
  final List<Product> _products = [
    Product(
        name: "Choose your jewel box",
        description:
            "Choose a jewel box that speaks to you. Select our signature Unsaid jewel box, or customise your gift with artwork",
        videoUrl:
            "https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-fashion-woman-with-silver-makeup-39875-large.mp4"),
    Product(
        name: "Write your card",
        description:
            "Explore cards with custom poems commissioned from our favourite writers. Customise yours with a personal note",
        videoUrl:
            "https://assets.mixkit.co/videos/preview/mixkit-conceptual-winter-fashion-couple-portrait-42051-large.mp4"),
    Product(
        name: "Write your card",
        description:
            "Explore cards with custom poems commissioned from our favourite writers. Customise yours with a personal note",
        videoUrl:
            "https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-fashion-cyborg-woman-40205-large.mp4"),
  ];

  final ScrollController _scrollController = ScrollController();
  late VideoPlayerController _controller0;
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  String text = '';
  String description = '';
  List _controllers = [];
  late AnimationController animationController;
  late Animation<TextStyle> animation;
  final Tween<double> _fontSizeTween = Tween(begin: 16.0, end: 32.0);
  @override
  void initState() {
    _controller0 = VideoPlayerController.network(_products[0].videoUrl)
      ..initialize();
    _controllers.add(_controller0);
    _controller1 = VideoPlayerController.network(_products[1].videoUrl)
      ..initialize();
    _controllers.add(_controller1);
    _controller2 = VideoPlayerController.network(_products[2].videoUrl)
      ..initialize();
    _controllers.add(_controller2);

    setState(() {});

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      end: const TextStyle(
        fontSize: 32,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ).animate(animationController);

    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container()),
          CarouselSlider.builder(
            itemCount: _controllers.length,
            options: CarouselOptions(
              height: 600,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              enlargeFactor: 0.3,
              onPageChanged: (i, carouselPageChangedReason) {
                if (i == 0) {
                  _controller0.play();
                } else if (i == 1) {
                  _controller1.play();
                } else if (i == 2) {
                  _controller2.play();
                } else {
                  _controller0.pause();
                  _controller1.pause();
                  _controller2.pause();
                }
                setState(() {
                  text = _products[i].name;
                  description = _products[i].description;
                });
              },
            ),
            itemBuilder: (context, index, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: VideoPlayer(_controllers[index]),
                  )),
                  ShowUpAnimation(
                      delayStart: Duration(milliseconds: 500),
                      animationDuration: Duration(milliseconds: 500),
                      curve: Curves.easeInSine,
                      direction: Direction.vertical,
                      offset: -0.5,
                      child: Column(children: [
                        ListTile(
                          title: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(text)),
                          subtitle: Text(description),
                        ),
                      ]))
                ],
              );
            },
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class ShowUpList {}

class Product {
  final String name;
  final String videoUrl;
  final String description;

  Product(
      {required this.name, required this.videoUrl, required this.description});
}
