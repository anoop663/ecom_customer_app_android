import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/account/model/account_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final loading = false.obs;
  final response = Rxn<AccountResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
    //getProfile();
  }

  //void getProfile() async {
  //  loading(true);
  //  try {
  //    response.value = await apiProvider.getAccountResponse();
  //  } catch (e) {
  //    Get.snackbar('Error', 'Failed to load profile: $e');
  //  } finally {
  //    loading(false);
  //  }
  //}

  void logoutFunction() async {
    Get.snackbar('Success', 'Logged out from the account',
              colorText: Colors.white, backgroundColor: Colors.black);
    try {
  storageProvider.clearStored();
} on Exception {
   Get.snackbar('Failed', 'Failed to logged out',
              colorText: Colors.white, backgroundColor: Colors.black);
}
  }
}
