import 'dart:convert';
import 'package:ecommerce_app/app/core/extensions/api_base_helper.dart';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_create_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/addressfunction_model.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/area_response.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/country_list.reponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAddressController extends GetxController {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var isLoading = false.obs;
  var response = Rxn<AddressListResponse>();
  var address = Rxn<Address>();
  Rxn<Address> address1 = Rxn();
  final count = 0.obs;
  final selectedAddressType = ''.obs;
  final selectedCountry = ''.obs;
  final selectedAreaId = ''.obs;
  final selectedAreaName = ''.obs;
  final selectedRegionId = ''.obs;
  final selectedZipcode = ''.obs;
  final Map<String, String> addressMap = {};
  final loading = false.obs;
  var addressTypeValue = 0.obs;
  //final repository = EcomApiClient();

  AddressListResponse? response1;
  Map<String, TextEditingController> textControllers = {};

  final addressAddResponse = Rxn<Success>();
  final countriesResponse = Rxn<CountryListResponse>();
  final areaResponse = Rxn<AreaResponse>();

//Adding new address
  void addtoAddressFunction(name, city, buildingnumber, country, mobile,area, zipcode, addresstype) async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressCreateModel addaddressData = AddressCreateModel(
      id: idToken.$1,
      token: idToken.$2,
      name: name,
      city: city,
      buildingnumber: buildingnumber,
      country: country,
      mobile: mobile,
      area: area,
      zipcode: zipcode,
      addresstype: addresstype,
      );

    try {
      final response = await authService.addAddress(addaddressData.toJson());
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

  void addressListFunction() async {
    (String?, String?) idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    AddressFunctionModel homeAuth3 = AddressFunctionModel(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response = await authService.getAddress(homeAuth3.toJson());
      isLoading.value = false;
//Check other status codes
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
}
