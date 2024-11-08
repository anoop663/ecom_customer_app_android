import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BrandSpecialCarousal extends StatelessWidget {
  BrandSpecialCarousal({super.key});
  
  final List<String> imageUrls = [
    'https://swan.alisonsnewdemo.online/images/banner/1690956916_1_HJ76vQftexQxoansOL9ZJ5g6rojKeGAWCUhElPq3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: screenSize.height * 0.4,  
        autoPlay: false,
        enlargeCenterPage: false,
        //aspectRatio: 9 / 9,
        viewportFraction: 1.0, 
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: screenSize.width,
              //margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
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
