import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/account/model/account_response.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:get/get.dart';
import 'dart:convert';

class AccountController extends GetxController {
  final loading = false.obs;
  final response = Rxn<AccountResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  @override
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

  void homeLoad() async {
    loading(true);
    try {
      final (String?, String?) idToken = storageProvider.readLoginDetails();
      final homeAuth = HomeAuth(id: idToken.$1, token: idToken.$2);

      final response = await authService.homePage(homeAuth.toJson());

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          Get.snackbar('Success', 'Home page loaded successfully');
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Loading failed');
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home page: $e');
    } finally {
      loading(false);
    }
  }
}
