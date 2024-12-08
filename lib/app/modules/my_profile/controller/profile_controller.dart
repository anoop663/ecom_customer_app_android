import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/my_profile/model/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final phoneController = TextEditingController();

  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  final isLoading = false.obs;
  final profileResponse = Rxn<ProfileResponse>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    final idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response = await authService.getAccountDetails(homeAuth.toJson());
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          final userProfile = ProfileResponse.fromJson(responseData);
          profileResponse.value = userProfile;
          populateTextFields(userProfile);
        } else {
          displayError(responseData['message'] ?? 'Profile data not found');
        }
      } else {
        displayError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      displayError('Failed to load profile details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void populateTextFields(ProfileResponse userProfile) {
    nameController.text = userProfile.customerData!.name ;
    phoneController.text = userProfile.customerData!.mobile ;
    mailController.text = userProfile.customerData!.email ;
  }

  void displayError(String message) {
    Get.snackbar(
      'Error',
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
    );
  }

  bool validateForm() {
    if (nameController.text.trim().isEmpty) {
      displayError('Name cannot be empty');
      return false;
    }
    return true;
  }
}
