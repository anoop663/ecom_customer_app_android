import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/modules/products/model/add_to_wishlist_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../home/models/home_product_model.dart';

class AddToWishlistController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;

  // Map to track favorite status by product slug
  var favoriteStatus = <String, bool>{}.obs;

  void toggleFavorite(
    String productSlug,
  ) async {
    // Toggle favorite status locally first
    if (favoriteStatus.containsKey(productSlug)) {
      favoriteStatus[productSlug] = !(favoriteStatus[productSlug]!);
    } else {
      favoriteStatus[productSlug] = true; // Default to favorite on first click
    }

    // Call the API to add/remove from wishlist
    await wislistFunction(productSlug);
  }

  void addAndRemovewishList({String? slug, bool? isBestItems}) async {
    var homedata = Get.find<HomeController>();
    Product? selectedProduct;

    if (isBestItems == true) {
      selectedProduct = homedata.homeResponse.value!.bestSeller!
          .firstWhere((e) => e.slug == slug, orElse: () => Product());
    } else {
      selectedProduct = homedata.homeResponse.value!.suggestedProducts!
          .firstWhere((e) => e.slug == slug, orElse: () => Product());
    }
   // print(selectedProduct.slug);
   // print(slug);
    if (selectedProduct.slug != null) {
      if (selectedProduct.wishlist!.value == 1) {
        selectedProduct.wishlist?.value = 0;
      } else {
        selectedProduct.wishlist?.value = 1;
      }
    }
    homedata.update();
    bool value = await addOrRemoveWishList(
        productSlug: slug,
        quantity: selectedProduct.wishlist!.value.toString()) as bool;
   // print(value);
    if (value == false) {
      if (selectedProduct.slug != null) {
        if (selectedProduct.wishlist!.value == 1) {
          selectedProduct.wishlist!.value = 0;
        } else {
          selectedProduct.wishlist!.value = 1;
        }
      }
    }
    homedata.update();
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
   // print(homeAuth2.toJson());
    try {
      final response = await authService.addToWishlist(homeAuth2.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          //Get.snackbar(
          //  'Success',
          //  'Item added to wishlist',
          //  colorText: AppColors.primary,
          //  backgroundColor: AppColors.textColor2,
          //);
          // Ensure favorite status is updated to true if API succeeds
          favoriteStatus[productSlug] = true;
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Item adding failed',
            colorText: AppColors.primary,
            backgroundColor: AppColors.textColor2,
          );
          // Revert the local toggle if the API fails
          favoriteStatus[productSlug] = false;
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          colorText: AppColors.primary,
          backgroundColor: AppColors.textColor2,
        );
        // Revert the local toggle if server error occurs
        favoriteStatus[productSlug] = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to add to wishlist: $e',
        colorText: AppColors.primary,
        backgroundColor: AppColors.textColor2,
      );
      // Revert the local toggle if exception occurs
      favoriteStatus[productSlug] = false;
    }
  }

  Future<bool?> addOrRemoveWishList(
      {String? productSlug, String? quantity}) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;
    HomeAuth2 homeAuth2 = HomeAuth2(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: quantity,
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
          //  colorText: AppColors.primary,
          //  backgroundColor: AppColors.textColor2,
          //);
          // Ensure favorite status is updated to true if API succeeds
          return true;
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Item adding failed',
            colorText: AppColors.primary,
            backgroundColor: AppColors.textColor2,
          );
          // Revert the local toggle if the API fails
          return false;
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          colorText: AppColors.primary,
          backgroundColor: AppColors.textColor2,
        );
        // Revert the local toggle if server error occurs
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to add to wishlist: $e',
        colorText: AppColors.primary,
        backgroundColor: AppColors.textColor2,
      );
      return false;
    }
  }
}
