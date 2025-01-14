import 'package:flutter/material.dart';

import '../core/values/colors.dart';

class CategoryTrend extends StatelessWidget {
  CategoryTrend({super.key});

  // List of brand images
  final List<String> brandImages = [
    'https://swan.alisonsnewdemo.online/images/category/1690970854.jpg',
    'https://swan.alisonsnewdemo.online/images/category/1690970920.jpg',
    'https://swan.alisonsnewdemo.online/images/category/1690970991.jpg',
    'https://swan.alisonsnewdemo.online/images/category/1690971057.jpg',
    'https://swan.alisonsnewdemo.online/images/category/1690971096.jpg',
    'https://swan.alisonsnewdemo.online/images/category/1690971154.jpg',
  ];

  // List of category titles
  final List<String> categoryTitles = [
    'Fashion',
    'Electronics',
    'Home Decor',
    'Beauty',
    'Sports',
    'Toys',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: brandImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 9.0, // Spacing between rows
        childAspectRatio: 0.75,
         // Adjust aspect ratio for image and text
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Align title to the left
          children: [
            // Category Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(brandImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8), // Spacing between image and title
            // Category Title
            Text(
              categoryTitles[index],
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Ensures long titles are truncated
            ),
          ],
        );
      },
      shrinkWrap: true, // Allows GridView to be inside a scrollable widget
      physics: const NeverScrollableScrollPhysics(), // Disables internal scrolling
    );
  }
}
