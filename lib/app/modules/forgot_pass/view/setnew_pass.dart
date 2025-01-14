import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/forgot_pass/controller/newpass_controller.dart';
import 'package:ecommerce_app/app/widgets/app_text_filed.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class SetNewPassword extends StatelessWidget {
  final NewpassController newpassController = Get.put(NewpassController());

  SetNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor2,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textColor1),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            SizedBox(
              width: screenSize.width,
              child: Image.asset(
                ImageStrings.splashImage1,
                color: AppColors.textColor2.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
              ),
            ),
            // Form Container
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(16),
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(height: 200),
                    // OTP TextField
                    AppTextField(
                      prefixIcon: IconStrings.passwordIcon,
                      hint: 'Enter OTP',
                      controller: newpassController.otpController,
                    ),
                    const SizedBox(height: 50),
                    // New Password Textfield
                    AppTextField(
                      prefixIcon: IconStrings.passwordIcon,
                      hint: 'New Password',
                      controller: newpassController.newPassController,
                      isObscure: newpassController.isPasswordVisible.value,
                      suffixIcon: IconStrings.obscureIcon,
                      onSuffixTap: newpassController.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 20),
                    // Confirm Password Textfield
                    AppTextField(
                      prefixIcon: IconStrings.passwordIcon,
                      hint: 'Confirm New Password',
                      controller: newpassController.confirmPassController,
                      isObscure:
                          newpassController.isConfirmPasswordVisible.value,
                      suffixIcon: IconStrings.obscureIcon,
                      onSuffixTap:
                          newpassController.toggleConfirmPasswordVisibility,
                    ),
                    const SizedBox(height: 50),
                    // Change Now Button
                    newpassController.isLoading.value
                        ? CircularProgressIndicator()
                        : CurvedButton(
                            onClick: newpassController.verifyOtp,
                            text: 'Change Now',
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
