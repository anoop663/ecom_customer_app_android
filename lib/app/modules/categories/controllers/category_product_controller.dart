import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/brands/model/brand_product_model.dart';
import 'package:ecommerce_app/app/modules/brands/model/brand_reponse_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class CategoriesProductController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  var isLoading = false.obs;
  //var getBrandProducts = BrandProductModel().obs;
  var brandproductResponse = Rxn<BrandReponseModel>();

  // Function to fetch brand products
  void getBrandProducts1(String by, String value) async {
    var idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    BrandProductModel brandProductModel = BrandProductModel(
      id: idToken.$1,
      token: idToken.$2,
      by: by,
      value: value,
    );

    try {
      final response = await authService.brandbaseProduct(brandProductModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          brandproductResponse.value = BrandReponseModel.fromJson(responseData);
          Get.snackbar('Success', 'Product Listed',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to retrieve products',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load products: $e',
          colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
    }
  }
}
