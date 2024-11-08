import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/forgot_pass/model/forgot_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;

  // Function to send OTP
  void forgotOtp() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Email address',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }

    isLoading.value = true;

    ForgotModel forgotModel = ForgotModel(
      email: emailController.text,
    );

    try {
      // Call the API to verify OTP
      final response = await authService.resetOtp(forgotModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          String userEmail = responseData['email'];

          Get.snackbar('Success', 'OTP send successfully',
              colorText: Colors.white, backgroundColor: Colors.black);
          Get.toNamed(Routes.setnewpass,
              arguments: {'email': userEmail}); // Navigate to setpassword page
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'OTP sending failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to send OTP: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
