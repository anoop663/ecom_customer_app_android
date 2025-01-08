import 'dart:convert';

import 'package:soulstyle/app/data/api_provider.dart';
import 'package:soulstyle/app/modules/forgot_pass/model/newpass_model.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewpassController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  var isLoading = false.obs;

  // Retrieve user ID passed from the registration page
  String userEmail = Get.arguments['email'];
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;

  // Toggles for password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Function to verify OTP

  void verifyOtp() async {
    if (otpController.text.isEmpty || newPassController.text.isEmpty || confirmPassController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all the details',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }
    if (newPassController.text != confirmPassController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }

    isLoading.value = true;

    NewPassModel otpModel = NewPassModel(
      code: otpController.text,
      password: newPassController.text,
      email: userEmail,
    );

    try {
      // Call the API to verify OTP
      final response = await authService.newPassword(otpModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          
          // Navigate to login page after successful OTP change
          Get.snackbar('Success', 'New Password set successfully',
              colorText: Colors.white, backgroundColor: Colors.black);
          Get.offAllNamed(Routes.signin);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Password setting failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to set Password: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  // Function to save user data locally
  Future<void> saveUserData(String custId, String token) async {
    // Example: Use GetStorage or SharedPreferences to save 'id' and 'token'
    final storage = GetStorage();
    await storage.write('id', custId);
    await storage.write('token', token);
  }
}
