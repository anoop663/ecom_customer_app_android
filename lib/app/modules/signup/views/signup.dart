import 'package:ecommerce_app/app/core/values/enums.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/signup/controllers/register_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_text_filed.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currentTheme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              child: Image.asset(
                ImageStrings.signupBg,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40.0,
              left: 16.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create Account",
                      style: currentTheme.textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    prefixIcon: IconStrings.fullNameIcon,
                    hint: 'Full Name',
                    controller: signupController.nameController,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    prefixIcon: IconStrings.phoneIcon,
                    hint: 'Phone Number',
                    controller: signupController.phoneController,
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    prefixIcon: IconStrings.mailIcon,
                    hint: 'Email',
                    controller: signupController.emailController,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  Obx(() => AppTextField(
                        prefixIcon: IconStrings.passwordIcon,
                        hint: 'Password',
                        controller: signupController.passwordController,
                        isObscure: signupController.isPasswordVisible.value,
                        suffixIcon: IconStrings.obscureIcon,
                        onSuffixTap: signupController.togglePasswordVisibility,
                      )),
                  const SizedBox(height: 20),
                  Obx(() => AppTextField(
                        prefixIcon: IconStrings.passwordIcon,
                        hint: 'Confirm Password',
                        controller: signupController.confirmPasswordController,
                        isObscure:
                            signupController.isConfirmPasswordVisible.value,
                        suffixIcon: IconStrings.obscureIcon,
                        onSuffixTap:
                            signupController.toggleConfirmPasswordVisibility,
                      )),
                  const SizedBox(height: 10),
                  Text(
                    "Password must contain minimum 6 characters, at least one upper case and one lower case",
                    style: currentTheme.textTheme.bodyMedium,
                  ),
                  // Gender Radio Buttons
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: const Text(
                                'Male',
                                style: TextStyle(color: Colors.white),
                              ),
                              value: Gender.male,
                              groupValue: signupController.selectedGender.value,
                              onChanged: (value) => signupController
                                  .selectedGender.value = value!,
                              activeColor: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              title: const Text(
                                'Female',
                                style: TextStyle(color: Colors.white),
                              ),
                              value: Gender.female,
                              groupValue: signupController.selectedGender.value,
                              onChanged: (value) => signupController
                                  .selectedGender.value = value!,
                              activeColor: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 30),
                  Text(
                    "By signing up, you agree with our Terms & Conditions and Privacy Policy.",
                    style: currentTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => signupController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CurvedButton(
                            onClick: signupController.register,
                            text: 'SignUp',
                          ),
                  ),
                  const SizedBox(height: 10),
                InkWell(
                            onTap: () {
                              Get.toNamed(Routes.signin);
                            },
                            child: Text(
                              "Already an account? Log In",
                              style: currentTheme.textTheme.bodyMedium,
                            ),
                          ),],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
