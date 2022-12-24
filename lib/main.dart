import 'package:animation_parallex/screens/main_screen.dart';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

void main() {
  runApp(const ParallaxApp());
}

class ParallaxApp extends StatefulWidget {
  const ParallaxApp({Key? key}) : super(key: key);

  @override
  State<ParallaxApp> createState() => _ParallaxAppState();
}

class _ParallaxAppState extends State<ParallaxApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Catalogue(),
    );
  }
}
