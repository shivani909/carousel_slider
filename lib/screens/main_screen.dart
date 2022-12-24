// write a program to display a catalogue of products with either a video or an image and a description of the product in a horizontal list view
//product video and description should change when you swipe left or right
//the video should play automatically when you swipe to it
//the video should stop playing when you swipe away from it
//the video should play again when you swipe back to it

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  bool _visible = true;
  late VideoPlayerController _controller0;
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  String text = '';
  String description = '';
  List _controllers = [];
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

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

    super.initState();
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
                  ListView(
                    
                    shrinkWrap: true,
                    children: [
                      AnimatedSwitcher(
                          child: ListTile(
                            title: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(text)),
                            subtitle: Text(description),
                          ),
                          duration: Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          })
                    ],
                  ),
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


class Product {
  final String name;
  final String videoUrl;
  final String description;

  Product(
      {required this.name, required this.videoUrl, required this.description});
}
