import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/modules/wishlist/model/remove_wishlist.dart';
import 'package:ecommerce_app/app/modules/wishlist/model/wishlist_response.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class RemoveFromWishlistController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var wishlistResponse = Rxn<WishListResponse>();
  String productSlug = '';

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    // removeFromWishlist(productSlug);
  }

   removeFromWishlist({String? productSlug,String? storeSlug}) async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final RemoveWishlist homeAuth2 = RemoveWishlist(
      id: idToken.$1,
      token: idToken.$2,
      slug: productSlug,
      quantity: '0',
      store: storeSlug,
    );

    try {
      final response = await authService.removeItemFromWishlist(homeAuth2.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
         Get.find<HomeController>().homeLoad(needLoading: false);
          //Get.snackbar('Success', 'Item removed successfully',
          //    colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Items removing failed',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to remove item: $e',
          colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
    }
  }
}
