import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../core/values/colors.dart';

class ProductCarousal extends StatelessWidget {
  ProductCarousal({super.key});

  // List of brand images
  final List<String> brandImages = [
    'https://swan.alisonsnewdemo.online/images/product/1691125472beE68sq76jHTfgoDhEEQl5PI9KT4KRz1p7XEGM58.webp',
    'https://swan.alisonsnewdemo.online/images/product/1690973722xe1zOpGrgvKKv7yqqfeSQscd4Qm7RcdArHEJKsO1.webp',
    'https://swan.alisonsnewdemo.online/images/product/1690973923kcNcn7whOLYYStHP6ExJC3xPmFLM98VlnOxwdl7G.webp',
  ];

  // List of product names and prices corresponding to the images
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
        height: screenSize.height * 0.34, // Increased height for image and text
        autoPlay: false,
        enlargeCenterPage: false,
        viewportFraction: 0.47, // Adjust to show 3 images
      ),
      itemCount: brandImages.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final imageUrl = brandImages[index];
        final productName = products[index]['name'];
        final productPrice = products[index]['price'];

        return Container(
          margin: const EdgeInsets.all(7.0),
          child: Stack(
            children: [
              // Image Section
              Container(
                height: screenSize.height * 0.27, // Adjusted image height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              
              // Positioned widget to place text on the bottom left
              Positioned(
                bottom: 5.0,  // Reduced padding from the bottom of the image
                left: 5.0,  // Padding from the left side
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      productName ?? 'Unknown Product',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.textColor2,
                      ),
                    ),
                    // Product Price
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
              ),
            ],
          ),
        );
      },
    );
  }
}
