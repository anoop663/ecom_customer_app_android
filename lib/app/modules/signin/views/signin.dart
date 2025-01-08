
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/core/values/strings.dart';
import 'package:soulstyle/app/modules/signin/controllers/signin_controller.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:soulstyle/app/widgets/app_text_filed.dart';
import 'package:soulstyle/app/widgets/curve_button.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final signinController = Get.put(SigninController());

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            child: Image.asset(
              ImageStrings.loginBg,
              color: AppColors.backgroundOverlay,
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                Container(
                  height: screenSize.height * 0.9,
                  width: screenSize.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Sign In",
                        style: currentTheme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 30),
                      // Email Field
                      AppTextField(
                        controller: signinController.emailController,
                        hint: "Email",
                        prefixIcon: IconStrings.mailIcon,
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                            signinController.emailError.value,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          )),
                      // Password Field with Toggle
                      Obx(() => AppTextField(
                            controller: signinController.passwordController,
                            isObscure: signinController.isPasswordVisible.value,
                            hint: "Password",
                            prefixIcon: IconStrings.passwordIcon,
                            suffixIcon: IconStrings.obscureIcon,
                            onSuffixTap: () {
                              signinController.isPasswordVisible.value =
                                  !signinController.isPasswordVisible.value;
                            },
                          )),
                      const SizedBox(height: 20),
                      // Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.forgotpage);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: currentTheme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Sign In Button with Loading State
                      Obx(() => CurvedButton(
                            onClick: signinController.isLoading.value
                                ? null
                                : () {
                                    signinController.loginHelper();
                                  },
                            width: screenSize.width,
                            isSelected: true,
                            text: signinController.isLoading.value
                                ? "Loading..."
                                : "Sign In",
                          )),
                      const SizedBox(height: 20),
                      // Sign Up Link
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: currentTheme.textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.signup);
                              },
                              child: Text(
                                "Create Account",
                                style: currentTheme.textTheme.displaySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
