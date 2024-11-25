import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppConstants {
  static const iconPath = 'assets/icons/';
  static const imagePath = 'assets/images/';
  static const animationPath = 'assets/animations/';
  
}

void appToast(String title, String message) {
  Get.snackbar(title, message,
      titleText: const SizedBox(),
      backgroundColor: AppColors.bottomSelectedColor,
      colorText: AppColors.textColor1,
      duration: const Duration(
        milliseconds: 800,
      ));
}