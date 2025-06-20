import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
import 'package:ecommerce_app/app/modules/products/model/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../home/models/home_product_model.dart';
import '../../products/controllers/product_controller.dart';

class CartController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  final loading = false.obs;
  var cartResponse = Rxn<CartResponse>();
  final scrollController = ScrollController();
  var cartItems = <Product>[].obs;
  var isRemoving = false.obs;
  var isRemovingItemSlug = ''.obs;
  var isMovingToWishlist = false.obs;
  var isMovingToWishlistSlug = ''.obs;

  /// Track loading states for each individual cart item
  final itemLoadingStates = <String, RxBool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    viewCart();
  }

  /// View cart details
  Future viewCart({bool needLoading = true}) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    loading.value = needLoading;

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
        // print('reds--$responseData');
        if (responseData['success'] == 1) {
          cartResponse.value = CartResponse.fromJson(responseData);
          cartItems.value = cartResponse.value!.products!;
          // Initialize loading states for each item
          for (var product in cartItems) {
            itemLoadingStates[product.slug!] = false.obs;
          }
        } else {
          cartResponse.value = null;
          // Get.snackbar(
          //     'Error', responseData['message'] ?? 'Items viewing failed',
          //     colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to view cart: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }

  /// Move to wishlist function
  Future<void> movetoWishListFunction(String productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    final loadingState = itemLoadingStates[productSlug];
    isMovingToWishlist.value = true;
    isMovingToWishlistSlug.value = productSlug;
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
      isMovingToWishlistSlug.value = '';
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartItems.removeWhere((item) => item.slug == productSlug);
          cartResponse.refresh();
          isMovingToWishlist.value = false;
          Get.snackbar('Success', 'Item moved to wishlist',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Item moving failed',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loadingState.value = false;
      Get.snackbar('Error', 'Failed to move to wishlist: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }

  /// Remove from cart function
  Future<void> removefromCartFunction(String productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    final loadingState = itemLoadingStates[productSlug];
    isRemoving.value = true;
    isRemovingItemSlug.value = productSlug;
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
      isRemovingItemSlug.value = '';
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          cartItems.removeWhere((item) => item.slug == productSlug);
          cartResponse.refresh();
          if (Get.isRegistered<ProductController>()) {
            var procduct = Get.find<ProductController>();
            if (procduct.productResponse.value?.product?.slug == productSlug) {
              procduct.fetchProductDetails(productSlug: productSlug);
            }
          } else {
            // ignore: avoid_print
            print('not registerd');
          }

          isRemoving.value = false;
          Get.snackbar('Success', 'Item removed from cart',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Item removing failed',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loadingState.value = false;
      Get.snackbar('Error', 'Failed to remove from cart: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }
}
