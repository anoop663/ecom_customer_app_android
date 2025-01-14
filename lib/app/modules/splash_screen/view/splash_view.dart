import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpashScreen extends StatelessWidget {
  SpashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            child: Image.asset(
              ImageStrings.splashImage3,
              color: AppColors.backgroundOverlay,
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                Container(
                  height: screenSize.height * 0.9,
                  width: screenSize.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 500,
                      ),
                      Text(
                        'Personalize Your Look',
                        style: currentTheme.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your style is your personal signature, So make it uniquely your and wear it with confidence..',
                        style: currentTheme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.accessoriesColor4,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
