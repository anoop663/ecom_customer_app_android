import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class HomeController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var homeResponse = Rxn<HomeResponse>();
  var productResponse = Rxn<HomeResponse>();

  void homeLoad({bool needLoading = true}) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = needLoading;

    HomeAuth homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response = await authService.homePage(homeAuth.toJson());
      isLoading.value = false;
//Check other status codes
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          // Parse the response into HomeResponse
          homeResponse.value = HomeResponse.fromJson(responseData);

          //Get.snackbar('Success', 'Home page loaded successfully',
          //    colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Home page loading failed',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load home page: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }


}
