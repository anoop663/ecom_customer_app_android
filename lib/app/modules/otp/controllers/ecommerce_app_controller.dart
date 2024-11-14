import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/otp/models/otp_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OtpController extends GetxController {
  final AuthService authService = AuthService();
  final TextEditingController otpController = TextEditingController();
  var isLoading = false.obs;

  // Retrieve user ID passed from the registration page
  String userId = Get.arguments['id'];

  // Function to verify OTP
  void verifyOtp() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter OTP',
          colorText: Colors.white, backgroundColor: Colors.black);
      return;
    }

    isLoading.value = true;

    OtpModel otpModel = OtpModel(
      id: userId,
      otp: otpController.text,
    );

    try {
      // Call the API to verify OTP
      final response = await authService.verifyUser(otpModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          String token = responseData['token'];
          String custId = responseData['id']; // Save token for future logins


          await saveUserData(custId, token);

          // Navigate to home page after successful OTP verification
          Get.snackbar('Success', 'OTP verified successfully',
              colorText: Colors.white, backgroundColor: Colors.black);
          Get.offAllNamed(Routes.bottombar);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Invalid OTP',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to verify OTP: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  Future<void> saveUserData(String custId, String token) async {
    final storage = GetStorage();
    await storage.write('id', custId);
    await storage.write('token', token);
  }
}
