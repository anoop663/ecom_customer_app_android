import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:soulstyle/app/modules/home/controllers/home_controller.dart';

class AppCarosal extends StatelessWidget {
  AppCarosal({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Obx(() {
      if (homeController.homeResponse.value != null &&
          homeController.homeResponse.value!.banner1 != null) {
        final banners = homeController.homeResponse.value!.banner1!;

        return CarouselSlider(
          options: CarouselOptions(
            height: screenSize.height * 0.3,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
          ),
          items: banners.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(
                    '${ApiConfig.bannerImageUrl}${banner.image ?? ''}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            );
          }).toList(),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
