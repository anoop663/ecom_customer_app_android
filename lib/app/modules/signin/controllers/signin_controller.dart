import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/signin/models/login_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SigninController extends GetxController {
  final AuthService authService = AuthService();
  var isLoading = false.obs;
  var isPasswordVisible = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginHelper() async {
    isLoading.value = true;
    LoginModel loginModel = LoginModel(
      email_phone: emailController.text,
      password: passwordController.text,
    );

    try {
      // Call the API to login with email and password
      final response = await authService.loginUser(loginModel.toJson());

      isLoading.value = false; // Stop the loading indicator

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Check if the response indicates success
        if (responseData['success'] == 1) {
          String userId = responseData['customerdata']['id'];
          String token = responseData['customerdata']['token'];

          // Save user ID and token in local storage
          await saveUserData(userId, token);

          // Show success message and navigate to home page
          Get.snackbar('Success', 'Login successful',
              colorText: Colors.white, backgroundColor: Colors.black);
          Get.offAllNamed(Routes.bottombar); // Navigate to home page
        } else {
          // Show error message from the response
          Get.snackbar('Error', responseData['message'] ?? 'Login failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        // Show server error message with status code
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      // Handle exception and show error message
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to login: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  // Function to save user data locally using GetStorage
  Future<void> saveUserData(String userId, String token) async {
    final storage = GetStorage();
    await storage.write('id', userId);
    await storage.write('token', token);
  }
}
