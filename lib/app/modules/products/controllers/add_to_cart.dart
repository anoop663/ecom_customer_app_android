import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/products/controllers/product_controller.dart';
import 'package:ecommerce_app/app/modules/products/model/add_to_cart_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class AddToCartController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var isItemSlug = ''.obs;

  void addtoCartFunction(
      {String? productSlug, String? quantity, String? from}) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;
    isItemSlug.value = productSlug!;
    HomeAuth3 homeAuth3 = HomeAuth3(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: quantity ?? '1',
      store: 'swan',
    );

    try {
      final response = await authService.addToCart(homeAuth3.toJson());
      isLoading.value = false;
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          Get.snackbar('Success', 'Item added to Cart',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
          Get.find<CartController>().viewCart(needLoading: false);
          isItemSlug.value = '';
          if (!Get.isRegistered<ProductController>()) {
            Get.put(ProductController());
            if (from == 'productDetails') {
              Get.put(ProductController())
                  .productResponse
                  .value!
                  .product
                  ?.cart = 1;
            }
          } else {
            Get.put(ProductController()).productResponse.value!.product?.cart =
                1;
          }
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Item adding failed',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
          isItemSlug.value = '';
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        isItemSlug.value = '';
      }
    } catch (e) {
      isLoading.value = false;
      isItemSlug.value = '';
      Get.snackbar('Error', 'Failed to add to Cart: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }
}
