import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/otp/controllers/ecommerce_app_controller.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  // Initialize OtpController
  final OtpController otpController = Get.put(OtpController());

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
              ImageStrings.otpBg,
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
                        'Verify Email',
                        style: currentTheme.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enter your OTP code here.',
                        style: currentTheme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.accessoriesColor4,
                          fontSize: 13,
                        ),
                      ),
                      TextField(
                        controller: otpController.otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          hintText: 'Enter OTP',
                          counterText: "",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          style: currentTheme.textTheme.bodySmall,
                          children: const [
                            TextSpan(
                              text: 'Didn\'t receive an OTP?',
                            ),
                            TextSpan(
                              text: ' ',
                            ),
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                color: AppColors.hyperLink,
                                decoration: TextDecoration.underline,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(() => CurvedButton(
                        onClick: () {
                          otpController.verifyOtp(); // Call the controller's verify function
                        },
                        width: screenSize.width,
                        text: 'Verify',
                        isSelected: true,
                        child: otpController.isLoading.value
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
