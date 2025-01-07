import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/wishlist/model/wishlist_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var wishlistResponse = Rxn<WishListResponse>();

  @override
  void onInit() {
    super.onInit();
    showWishListFunction();
  }

  void showWishListFunction() async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final HomeAuth homeAuth2 = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );
    // ignore: avoid_print
    print(homeAuth2.toJson());
    try {
      final response = await authService.showWishlist(homeAuth2.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          wishlistResponse.value = WishListResponse.fromJson(responseData);

          //Get.snackbar('Success', 'WishList showing successfully',
          //    colorText: Colors.white, backgroundColor: Colors.black);
        } else if (responseData['success'] == 0) {
          wishlistResponse.value = null;
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Items showing failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to show wishlist: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
