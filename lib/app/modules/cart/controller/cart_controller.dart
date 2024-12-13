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

  /// Track loading states for each individual cart item
  final itemLoadingStates = <String, RxBool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    viewCart();
  }


  /// View cart details
  Future viewCart() async {
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
          cartItems.value = cartResponse.value!.products!;
          // Initialize loading states for each item
          for (var product in cartItems) {
            itemLoadingStates[product.slug!] = false.obs;
          }
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

  /// Move to wishlist function
  Future<void> movetoWishListFunction(String productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    final loadingState = itemLoadingStates[productSlug];
    isMovingToWishlist.value = true;

    if (loadingState == null) return;

    loadingState.value = true;

    HomeAuth3 homeAuth3 = HomeAuth3(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '1',
      store: 'swan',
    );

    try {
      final response = await authService.moveToWishlist(homeAuth3.toJson());
      loadingState.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartItems.removeWhere((item) => item.slug == productSlug);
          cartResponse.refresh();
          isMovingToWishlist.value = false;
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
      loadingState.value = false;
      Get.snackbar('Error', 'Failed to move to wishlist: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  /// Remove from cart function
  Future<void> removefromCartFunction(String productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    final loadingState = itemLoadingStates[productSlug];
    isRemoving.value = true;

    if (loadingState == null) return;

    loadingState.value = true;

    HomeAuth4 homeAuth4 = HomeAuth4(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '0',
      store: 'swan',
    );

    try {
      final response = await authService.addToCart(homeAuth4.toJson());
      loadingState.value = false;
      isRemoving.value = true;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartItems.removeWhere((item) => item.slug == productSlug);
          cartResponse.refresh();

          isRemoving.value = false;
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
      loadingState.value = false;
      Get.snackbar('Error', 'Failed to remove from cart: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
