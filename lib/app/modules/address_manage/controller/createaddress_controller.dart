import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/addressfunction_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAddressController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var response = Rxn<AddressListResponse>();

//Adding new address
  void addtoAddressFunction() async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    HomeAuth addaddress = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
      
    );

    try {
      final response = await authService.addAddress(addaddress.toJson());
      isLoading.value = false;
//Check other status codes
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {

          Get.snackbar('Success', 'Address added',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Address adding failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to add address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
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
          Get.snackbar(
              'Error', responseData['message'] ?? 'Item adding failed',
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
      final response = await authService.deleteAddress(homeAuth3.toJson());
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


   void addressListFunction() async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressFunctionModel homeAuth3 = AddressFunctionModel(
      id: idToken.$1,
      token: idToken.$2,
      
    );

    try {
      final response = await authService.listAddress(homeAuth3.toJson());
      isLoading.value = false;
//Check other status codes
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {

          Get.snackbar('Success', 'Item added to Cart',
              colorText: Colors.white, backgroundColor: Colors.black);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Item adding failed',
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
}


