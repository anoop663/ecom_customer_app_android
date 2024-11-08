import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BrandCarosal extends StatelessWidget {
  BrandCarosal({super.key});
     // List of brand images
    final List<String> brandImages = [
      'https://swan.alisonsnewdemo.online/images/manufacturer/1690881096.png',
      'https://swan.alisonsnewdemo.online/images/manufacturer/1690625215.png',
      'https://swan.alisonsnewdemo.online/images/manufacturer/1690625181.png',
      // Add more image URLs here as needed
    ];

  final List<String> imageUrls = [
    'https://swan.alisonsnewdemo.online/images/banner/1695716382_1_sH4k9mEPpOeGBInBvUUc9G2X3tXUhPE41ZH3Vp5B.webp',
    'https://swan.alisonsnewdemo.online/images/manufacturer/1690543931.png',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: screenSize.height * 0.2, // Adjust height
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 0.34, // Adjust to show 3 images
      ),
      items: brandImages.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
