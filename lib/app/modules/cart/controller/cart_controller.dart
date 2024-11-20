import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
import 'package:ecommerce_app/app/modules/products/model/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/models/home_product_model.dart';

class CartController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  final loading = false.obs;
  var cartResponse = Rxn<CartResponse>();
  final scrollController = ScrollController();
  var cartItems = <Product>[].obs;
  var isRemoving = false.obs;
  var isMovingToWishlist = false.obs;
  var rebuildTrigger = false.obs;
  var cartResponse1 = Rx<CartModel?>(null);

  @override
  void onInit() {
    super.onInit();
    viewCart();
  }

  void toggleLoading() {
    loading.value = !loading.value;
  }

  void refreshCartView() {
    update();
  }

  void viewCart() async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    loading.value = true;

    final CartModel homeAuth2 = CartModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: '10',
      shippingaddressId: '10',
      forwhat: 'summary',
    );

    try {
      final response = await authService.viewtheCart(homeAuth2.toJson());
      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {

          cartResponse.value = CartResponse.fromJson(responseData);
          cartItems.value = cartResponse.value!.products!; // Update cart items
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Items viewing failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to view cart: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  // Move to wishlist function
  movetoWishListFunction(productSlug) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isMovingToWishlist.value = true;

    HomeAuth3 homeAuth3 = HomeAuth3(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '1',
      store: 'swan',
    );

    try {
      final response = await authService.moveToWishlist(homeAuth3.toJson());
      isMovingToWishlist.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          // Remove the item from cartItems
          cartItems.removeWhere((item) => item.slug == productSlug);
          cartResponse.refresh();
          //cartResponse1.refresh();// Update UI
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
      isMovingToWishlist.value = false;
      Get.snackbar('Error', 'Failed to move to wishlist: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  // Remove from cart function
  removefromCartFunction(productSlug) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isRemoving.value = true;

    HomeAuth4 homeAuth4 = HomeAuth4(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '0',
      store: 'swan',
    );

    try {
      final response = await authService.addToCart(homeAuth4.toJson());
      isRemoving.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          // Remove the item from cartItems
          cartItems.removeWhere((item) => item.slug == productSlug);
         cartResponse.refresh();
         //cartResponse1.refresh(); // Update UI
          Get.snackbar('Success', 'Item removed from cart',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Item removing failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isRemoving.value = false;
      Get.snackbar('Error', 'Failed to remove from Cart: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
