import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../core/values/colors.dart';

class BestSeller extends StatelessWidget {
  BestSeller({super.key});

  final List<String> brandImages = [
    'https://swan.alisonsnewdemo.online/images/product/1695193145cNtaBxG8d9mn4nj18u7fOJVSZX0H4JDNCN2SUsj5.webp',
    'https://swan.alisonsnewdemo.online/images/product/1691660144YkQOQNhU99CdrWJLIRcoHV1wPCLPARhBcWFfndUd.webp',
    'https://swan.alisonsnewdemo.online/images/product/1695717977ErdN5zvcFa9HlXsNxUTmnS3EEZWUVyOVnItpupVK.webp',
  ];

  final List<Map<String, String>> products = [
    {'name': 'Product 1', 'price': '\$100'},
    {'name': 'Product 2', 'price': '\$120'},
    {'name': 'Product 3', 'price': '\$80'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: screenSize.height * 0.34,
        autoPlay: false,
        enlargeCenterPage: false,
        viewportFraction: 0.47,
      ),
      itemCount: brandImages.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final imageUrl = brandImages[index];
        final productName = products[index]['name'];
        final productPrice = products[index]['price'];

        return Container(
          margin: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 5.0), // Small space between image and text
              Text(
                productName ?? 'Unknown Product',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColors.textColor2,
                ),
              ),
              Text(
                productPrice ?? 'Unknown Price',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.textColor2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
