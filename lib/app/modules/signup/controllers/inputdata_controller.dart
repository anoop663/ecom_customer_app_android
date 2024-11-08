import 'package:ecommerce_app/app/core/values/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var selectedGender = Gender.male.obs;
  var isLoading = false.obs;

  var isPhoneNumberValid = true.obs;
  var isEmailValid = true.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void validatePhoneNumber(String phone) {
    if (phone.length == 10) {
      isPhoneNumberValid.value = true;
    } else {
      isPhoneNumberValid.value = false;
    }
  }

  void validateEmail(String email) {
    // Regular expression for basic email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (emailRegex.hasMatch(email)) {
      isEmailValid.value = true;
    } else {
      isEmailValid.value = false;
    }
  }

  void register() {
    if (!isPhoneNumberValid.value || !isEmailValid.value) {
      Get.snackbar('Error', 'Please ensure all fields are valid');
      return;
    }
  }
}
