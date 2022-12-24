import 'package:flutter/material.dart';

class PreviousVisuals extends StatelessWidget {
  const PreviousVisuals({
    Key? key, 
    required this.imageUrl, 
    required this.name, 
    required this.country}) : super(key: key);

  final String imageUrl;
  final String name;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      child: AspectRatio(aspectRatio: 16/9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: const [
          
          ],

        ),
      ),
      ),
    );
  }
}
