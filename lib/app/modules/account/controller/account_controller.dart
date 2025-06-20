import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/account/model/account_response.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class AccountController extends GetxController {
  final isLoading = false.obs;
  final response = Rxn<AccountResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  @override
  void onInit() {
  super.onInit();
  getProfile();
  }

  void getProfile() async {
    final idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final res = await authService.getProfile(homeAuth.toJson());
      if (res.statusCode == 200) {
        final responseData = json.decode(res.body);

        if (responseData['success'] == 1) {
          response.value = AccountResponse.fromJson(responseData);
        } else {
          displayError(responseData['message'] ?? 'Profile data not found');
        }
      } else {
        displayError('Server error: ${res.statusCode}');
      }
    } catch (e) {
      displayError('Failed to load profile details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logoutFunction() async {
    try {
      await storageProvider.clearStored();
      Get.snackbar(
        'Success',
        'Logged out from the account',
        colorText: AppColors.primary,
        backgroundColor: AppColors.textColor2,
      );
    } catch (e) {
      Get.snackbar(
        'Failed',
        'Failed to log out: $e',
        colorText: AppColors.primary,
        backgroundColor: AppColors.textColor2,
      );
    }
  }

  void displayError(String message) {
    Get.snackbar(
      'Error',
      message,
      colorText: AppColors.primary,
      backgroundColor: AppColors.redColor,
    );
  }
}
