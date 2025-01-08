import 'dart:convert';
import 'package:soulstyle/app/data/api_provider.dart';
import 'package:soulstyle/app/modules/forgot_pass/model/forgot_model.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;

  // Email validation function
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Function to send OTP
  void forgotOtp() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter Email address',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid Email address',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }

    isLoading.value = true;

    ForgotModel forgotModel = ForgotModel(
      email: email,
    );

    try {
      // Calling API
      final response = await authService.resetOtp(forgotModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          String userEmail = responseData['email'];

          Get.snackbar('Success', 'OTP sent successfully',
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
