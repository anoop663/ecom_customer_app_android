import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/products/model/product_model.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/products/model/product_response_model.dart';

import '../../../core/values/colors.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productResponse = Rxn<ProductDetailsResponse>();
  final StorageProvider storageProvider = StorageProvider();
  final AuthService authService = AuthService();

  Future<void> fetchProductDetails({required String productSlug}) async {
    // Retrieve the login details (id and token) from StorageProvider
    var idToken = storageProvider.readLoginDetails();

    // Set loading state to true
    isLoading.value = true;

    // Create ProductRequest model with retrieved values and passed parameters
    ProductRequest productRequest = ProductRequest(
      id: idToken.$1!,
      token: idToken.$2!,
      isVariant: 1,
      parentId: 331,
      optionIds: [2, 4],
    );

    try {
      // Send the request using authService
      final response = await authService.productFetch(productRequest.toJson(), productSlug);

      // Set loading state to false after request completes
      isLoading.value = false;

      if (response.statusCode == 200) {
        // Decode the JSON response body
        final responseData = json.decode(response.body);

        // Check if response indicates success
        if (responseData['success'] == 1) {
          // Set the response model
          productResponse.value = ProductDetailsResponse.fromJson(responseData);

          // Show a success message
          //Get.snackbar(
          //  'Success',
          //  'Product Listed',
          //  colorText: AppColors.primary,
          //  backgroundColor: AppColors.textColor2,
          //);
        } else {
          // Show an error message with response message or fallback
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to retrieve products',
            colorText: AppColors.primary,
            backgroundColor: AppColors.textColor2,
          );
        }
      } else {
        // Handle server error status codes
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          colorText: AppColors.primary,
          backgroundColor: AppColors.textColor2,
        );
      }
    } catch (e) {
      // Set loading state to false on error
      isLoading.value = false;

      // Show an error message with exception details
      Get.snackbar(
        'Error',
        'Failed to load products: $e',
        colorText: AppColors.primary,
        backgroundColor: AppColors.textColor2,
      );
    }
  }
}
