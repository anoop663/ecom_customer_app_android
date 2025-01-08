import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulstyle/app/data/api_provider.dart';
import 'package:soulstyle/app/data/storage_provider.dart';
import 'package:soulstyle/app/modules/products/model/add_to_wishlist_model.dart';

class AddToWishlistController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;

  // Map to track favorite status by product slug
  var favoriteStatus = <String, bool>{}.obs;

  void toggleFavorite(String productSlug) async {
    // Toggle favorite status locally first
    if (favoriteStatus.containsKey(productSlug)) {
      favoriteStatus[productSlug] = !(favoriteStatus[productSlug]!);
    } else {
      favoriteStatus[productSlug] = true; // Default to favorite on first click
    }

    // Call the API to add/remove from wishlist
    await wislistFunction(productSlug);
  }

  Future<void> wislistFunction(String productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    HomeAuth2 homeAuth2 = HomeAuth2(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '1',
      store: 'swan',
    );

    try {
      final response = await authService.addToWishlist(homeAuth2.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          //Get.snackbar(
          //  'Success',
          //  'Item added to wishlist',
          //  colorText: Colors.white,
          //  backgroundColor: Colors.black,
          //);
          // Ensure favorite status is updated to true if API succeeds
          favoriteStatus[productSlug] = true;
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Item adding failed',
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
          // Revert the local toggle if the API fails
          favoriteStatus[productSlug] = false;
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        // Revert the local toggle if server error occurs
        favoriteStatus[productSlug] = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to add to wishlist: $e',
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      // Revert the local toggle if exception occurs
      favoriteStatus[productSlug] = false;
    }
  }
}
