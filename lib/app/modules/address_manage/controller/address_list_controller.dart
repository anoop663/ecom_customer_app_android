import 'dart:convert';
import 'package:ecommerce_app/app/core/extensions/api_base_helper.dart';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_remove_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to list address',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  void removeAddress(String id, {required String addressId}) async {
    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    AddressRemoveModel addressRemoveModel = AddressRemoveModel(
      id: idToken.$1,
      token: idToken.$2,
      addressid: id,
    );

    try {
      final response =
          await authService.removeAddress(addressRemoveModel.toJson());

      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          addressresponse1.value = AddressListResponse.fromJson(responseData);
          Get.snackbar('Success', 'Address Removed',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to remove address',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to remove address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
