import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/wishlist/model/remove_wishlist.dart';
import 'package:ecommerce_app/app/modules/wishlist/model/wishlist_response.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class AddToBagFromWishlistController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var wishlistResponse = Rxn<WishListResponse>();
  String productSlug = '';

  @override
  void onInit() {
    super.onInit();
    movetoCartWishlist(productSlug);
  }

   movetoCartWishlist(productSlug) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final RemoveWishlist homeAuth2 = RemoveWishlist(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '1',
      store: 'swan',
    );

    try {
      final response = await authService.removeWishlist(homeAuth2.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          

          Get.snackbar('Success', 'Item moved to cart',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Items moving failed',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to move item: $e',
          colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
    }
  }
}
