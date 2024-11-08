import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/cart/controller/remove_from_cart.dart';
import 'package:ecommerce_app/app/modules/products/model/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoveToWishlistController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  CartController controller = CartController();
  RemoveFromCartController removeFromCartController =
      RemoveFromCartController();

  void movetoWishListFunction(productSlug) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    HomeAuth3 homeAuth3 = HomeAuth3(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '1',
      store: 'swan',
    );

    try {
      final response = await authService.moveToWishlist(homeAuth3.toJson());
      isLoading.value = false;
      //Check other status codes
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          removeFromCartController.removefromCartFunction(productSlug);
          controller.refreshCartView();

          Get.snackbar('Success', 'Item moved to wishlist',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Item moving failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to move to wishlist: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
