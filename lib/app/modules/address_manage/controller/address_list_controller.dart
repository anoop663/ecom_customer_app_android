import 'dart:convert';
import 'package:ecommerce_app/app/core/extensions/api_base_helper.dart';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class MyAddressListController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  final count = 0.obs;
  final loading = false.obs;
  final removeLoading = false.obs;
  final tempAddressId = ''.obs;
  //final repository = EcomApiClient();
  final addressresponse = Rxn<AddressListResponse>();
  final addressresponse1 = Rxn<AddressListResponse>();
  var address = Rxn<Address>();

  final removeResponse = Rxn<Success>();
  @override
  void onInit() {
    super.onInit();
    getAddressFunction();
  }

  void getAddressFunction() async {
    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    HomeAuth authData5 = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );
    try {
      final response = await authService.getAddress(authData5.toJson());
      loading.value = false;
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          addressresponse.value = AddressListResponse.fromJson(responseData);

          Get.snackbar('Success', 'Address Listed',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to list address',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load address: $e',
          colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
    }
  }
}
