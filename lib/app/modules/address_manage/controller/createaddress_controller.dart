import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_create_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/addressfunction_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAddressController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  var isLoading = false.obs;
  //final addressTypeValue = AddressType.home.obs;
  var addressTypeValue = 0.obs;
  final addressForm = GlobalKey<FormState>();
  var isDefaultValue = 1.obs; 

  // Address input controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final buildingController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipcodeController = TextEditingController();

  void addAddressFunction({
    required String fullName,
    required String phoneNumber,
    required String building,
    required String city,
    required String state,
    required String postCode,
    required String country,
    required String isDefault,

    //required String addressTypeValue,
  }) async {
    // Retrieve stored user ID and token
    final idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    // Create address model
    final addressData = AddressCreateModel(
      id: idToken.$1,
      token: idToken.$2,
      name: fullName,
      city: city,
      buildingnumber: building,
      country: '99',
      mobile: phoneNumber,
      area: city,
      zipcode: postCode,
      isDefault:isDefault,
      addresstype: addressTypeValue.toString(),
    );

    try {
      final response = await authService.addAddress(addressData.toJson());
      isLoading.value = true;

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['success'] == 1) {
        Get.snackbar(
          'Success',
          'Address added',
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );

        // Add a 2-second delay before navigating to the address page
        await Future.delayed(const Duration(seconds: 2));
        Get.toNamed(Routes.address);
      } else {
        Get.snackbar(
            'Error', responseData['message'] ?? 'Failed to add address',
            colorText: Colors.white,
            backgroundColor: const Color.fromARGB(255, 203, 165, 165));
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to add address: $e',
          colorText: Colors.white,
          backgroundColor: const Color.fromARGB(255, 208, 169, 169));
    }
  }

  //Editng addresss
  void editAddressFunction(addressid) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressFunctionModel homeAuth3 = AddressFunctionModel(
      id: idToken.$1,
      token: idToken.$2,
      addressid: addressid,
    );

    try {
      final response = await authService.editAddress(homeAuth3.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          Get.snackbar('Success', 'Item added to Cart',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar('Error', responseData['message'] ?? 'Item adding failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to add to Cart: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  void deleteAddressFunction(addressid) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressFunctionModel homeAuth3 = AddressFunctionModel(
      id: idToken.$1,
      token: idToken.$2,
      addressid: addressid,
    );

    try {
      final response = await authService.removeAddress(homeAuth3.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          Get.snackbar('Success', 'Address Deleted',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Address deleting failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to delete address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  void updateAddressFunction(addressid) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressFunctionModel homeAuth3 = AddressFunctionModel(
      id: idToken.$1,
      token: idToken.$2,
      addressid: addressid,
    );

    try {
      final response = await authService.updateAddress(homeAuth3.toJson());
      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          Get.snackbar('Success', 'Address updated',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Address updation failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to update address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
