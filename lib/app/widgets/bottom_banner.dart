import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BottomCarousal extends StatelessWidget {
  BottomCarousal({super.key});

  final List<String> imageUrls = [
    'https://swan.alisonsnewdemo.online/images/banner/1690193506_2_ODUTsdkpr9lf0NnBeqn0BdKaK3COVXbnfKj7hKs2.webp'
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(url),
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
