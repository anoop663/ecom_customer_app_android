import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
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

  @override
  void onInit() {
    super.onInit();
    viewCart();
  }

  void toggleLoading() {
    loading.value = !loading.value;
  }

  var isRemoving1 = false.obs;
  var isMovingToWishlist1 = false.obs;
  var rebuildTrigger = false.obs;

  void refreshCartView() {
    //viewCart();
     rebuildTrigger.value = !rebuildTrigger.value;
  }

  void viewCart() async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    loading.value = true;

    final CartModel homeAuth2 = CartModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: '12',
      shippingaddressId: '12',
      forwhat: 'summary',
    );

    try {
      final response = await authService.viewtheCart(homeAuth2.toJson());
      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartResponse.value = CartResponse.fromJson(responseData);

          Get.snackbar('Success', 'Cart listed successfully',
              colorText: Colors.white, backgroundColor: Colors.black);
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
}
