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
  CarouselController _carouselController = CarouselController();
  // late Animation<TextStyle> animation;
  // final Tween<double> _fontSizeTween = Tween(begin: 16.0, end: 32.0);

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

    // setState(() {});

    // animationController = AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 1000));

    // animation = TextStyleTween(
    //   begin: const TextStyle(
    //     fontSize: 16,
    //     color: Colors.black,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   end: const TextStyle(
    //     fontSize: 32,
    //     color: Colors.black,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ).animate(animationController);

    // animation.addListener(() {
    //   setState(() {});
    // });
    // animationController.forward();
    super.initState();
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 42.0, top: 42, bottom: 42),
                child: Text(
                  'Make it personal',
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: 18,
                    fontFamily: 'Montas',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              CarouselSlider.builder(
                itemCount: _controllers.length,
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.8,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: VideoPlayer(_controllers[index]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20),
                        child: ShowUpAnimation(
                            delayStart: const Duration(milliseconds: 500),
                            animationDuration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            direction: Direction.vertical,
                            offset: -0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  text,
                                  style: const TextStyle(
                                    letterSpacing: 0.5,
                                    height: 2,
                                    fontSize: 26,
                                    fontFamily: 'Montas',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  description,
                                  style: const TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 15,
                                    height: 1.3,
                                    fontFamily: 'Montas',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                },
              ),
        
              // Padding(
              //   padding: const EdgeInsets.only(left: 36.0, right: 20),
              //   child: ShowUpAnimation(
              //       delayStart: const Duration(milliseconds: 500),
              //       animationDuration: const Duration(milliseconds: 500),
              //       curve: Curves.easeInOut,
              //       direction: Direction.vertical,
              //       offset: -0.5,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             text,
              //             style: const TextStyle(
              //               letterSpacing: 0.5,
              //               height: 2,
              //               fontSize: 26,
              //               fontFamily: 'Montas',
              //               fontWeight: FontWeight.w300,
              //             ),
              //           ),
              //           const SizedBox(height: 10),
              //           Text(
              //             description,
              //             style: const TextStyle(
              //               letterSpacing: 0.8,
              //               fontSize: 18,
              //               height: 1.3,
              //               fontFamily: 'Montas',
              //               fontWeight: FontWeight.w200,
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
            ],
          ),
        ),
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
