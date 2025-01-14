import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/modules/web_view_pages/model/web_view_response.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class WebViewController extends GetxController {
  final isLoading = false.obs;
  final response = Rxn<PageContentResponse>();
  final AuthService authService = AuthService();
  var pageContentResponse = Rxn<PageContentResponse>();

  final count = 0.obs;
  final title = ''.obs;
  final link = ''.obs;
  final content = ''.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['title'] != null) {
      title(Get.arguments['title']);

      if (title.toLowerCase().contains('privacy')) {
        content.value =
            'What is a privacy policy? \n A privacy policy (also referred to as a privacy notice) is a statement or legal document that describes how a company, website, or app collects, uses, maintains, and shares information collected from or about its users. Most countries require any website that collects personal information from its users to have a written privacy policy posted on the website.\n\nDoes Termly Privacy Policy Generator cover all privacy laws?\n\nTermly’s Privacy Policy Generator is designed to help you comply with the following regions:\nEU (GDPP)\nUK (UK GDPR)\nCalifornia (CCPA, CPRA, and CalOPPA)\nColorado (CPA)\nConnecticut (CTDPA)\nIn many cases, our Privacy Policy Generator could help you comply with other privacy laws. However, Termly’s products aren’t specifically built to comply with laws outside of the above list. We recommend consulting with a local attorney for any laws not yet specifically included in our offerings. Click here to learn more about which privacy laws Termly Privacy Policy Generator covers.\n\nHow does Termly help you keep your privacy policy up to date?\n\nTermly publishes periodic version updates to policies. ';
      }
      if (title.toLowerCase().contains('terms')) {
        content.value =
            "Welcome to Swan, an ecommerce platform provided by Swan (\"Company\", \"we\", \"us\", or \"our\"). By accessing or using the Swan mobile application (the \"App\") or our website (the \"Site\"), you agree to comply with and be bound by these Terms and Conditions (\"Terms\"). If you do not agree to these Terms, please do not use our App or Site.\n\n1.1\tEligibility: You must be at least 18 years old to use our App and Site. By using our App and Site, you represent and warrant that you are at least 18 years old.\n\n1.2\tAccount: To use certain features of the App and Site, you may be required to create an account. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account.\n\n2.1\tProduct Information: We strive to provide accurate descriptions and images of products on our App and Site. However, we do not warrant that the product descriptions, images, or other content is accurate, complete, reliable, current, or error-free.\n\n2.2\tPricing: Prices for products are subject to change without notice. We reserve the right to modify or discontinue any product without notice at any time.\n\n3.1\tPayment: You agree to pay all fees and charges incurred through your account at the rates in effect for the billing period in which such fees and charges are incurred, including, but not limited to, charges for products, shipping, and handling.\n\n3.2\tBilling Information: You agree to provide and maintain accurate, current, and complete billing information. You authorize us to charge your provided payment method for any purchases made through your account.\n\n4.1\tOwnership: All content, trademarks, service marks, trade names, and other intellectual property rights on the App and Site are owned by or licensed to Swan and are subject to copyright and other intellectual property rights under applicable laws.\n\n4.2\tUse: You may not use, reproduce, modify, transmit, display, publish, sell, create derivative works, or distribute by any means, method, or process whatsoever, now known or hereafter developed, any content of the App or Site for commercial profit or gain.\n\n5.1\tPrivacy Policy: Your use of the App and Site is also governed by our Privacy Policy, which is incorporated by reference into these Terms. Please review our Privacy Policy to understand our practices.\n\n6\tTermination: We may terminate or suspend your account and access to the App and Site immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these Terms.\n\n7\tChanges to Terms: We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.\n\n8\tContact Us: If you have any questions about these Terms, please contact us at swandeveloperoman@gmail.com.";
      }
    }
    if (Get.arguments['link'] != null) {
      link(Get.arguments['link']);
      getPageContent(link);
    }
  }

  void getPageContent(link) async {

    try {
      final response = await authService.getPageContents(link);

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          pageContentResponse.value = PageContentResponse.fromJson(responseData);
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
