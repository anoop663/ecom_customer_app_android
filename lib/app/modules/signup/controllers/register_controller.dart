import 'dart:convert'; // Needed for json decoding
import 'package:ecommerce_app/app/core/values/enums.dart';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/signup/models/register_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class SignupController extends GetxController {
  final AuthService authService = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var selectedGender = Gender.male.obs;
  var isLoading = false.obs;

  // Regular expressions for validation
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\d{10}$');

  // Toggles for password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Validate inputs before calling API
  bool validateInputs() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Full name is required',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      return false;
    }
    if (phoneController.text.isEmpty || !phoneRegex.hasMatch(phoneController.text)) {
      Get.snackbar('Error', 'Enter a valid phone number',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      return false;
    }
    if (emailController.text.isEmpty || !emailRegex.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Enter a valid email',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      return false;
    }
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      return false;
    }
    return true;
  }

  // Register Function
  void register() async {
    //Checking filed validations
    if (!validateInputs()) return; 

    isLoading.value = true;
    
    UserModel userModel = UserModel(
      name: nameController.text,
      email: emailController.text,
      phoneCountryCode: '971',
      phoneNumber: phoneController.text,
      password: passwordController.text,
      gender: selectedGender.value == Gender.male ? 'male' : 'female',
    );

    try {
      final response = await authService.registerUser(userModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          String userId = responseData['customerdata']['id'];

          Get.snackbar(
              'Success', responseData['message'] ?? 'Registration successful',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
          Get.toNamed(Routes.otp, arguments: {'id': userId});
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Registration failed',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to register: $e',
          colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
    }
  }
}
