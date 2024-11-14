import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/forgot_pass/controller/forgot_controller.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});

  final ForgotController forgotController = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            child: Image.asset(
              ImageStrings.forgotBg,
              color: AppColors.backgroundOverlay,
              colorBlendMode: BlendMode.multiply,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
              onPressed: () {
                Get.back();
              },
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Text(
                        'Forgot Password',
                        style: currentTheme.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please enter your email so we can send you an OTP.',
                        style: currentTheme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.accessoriesColor4,
                          fontSize: 13,
                        ),
                      ),
                      TextField(
                        controller: forgotController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          hintText: 'Enter Email',
                          counterText: "",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(() => CurvedButton(
                        onClick: forgotController.isLoading.value
                            ? null
                            : () => forgotController.forgotOtp(),
                        width: screenSize.width,
                        text: 'Send',
                        isSelected: true,
                        child: forgotController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : null,
                      )),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
