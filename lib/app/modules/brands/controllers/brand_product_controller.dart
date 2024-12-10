import 'dart:convert';
import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/brands/controllers/filter_controller.dart';
import 'package:ecommerce_app/app/modules/brands/model/brand_filter_model.dart';
import 'package:ecommerce_app/app/modules/brands/model/brand_reponse_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandProductController extends GetxController {
  // Retrieve passed arguments
  final String by = Get.arguments['by'];
  final String value = Get.arguments['value'];
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  var isLoading = false.obs;
  var brandproductResponse = Rxn<BrandReponseModel>();

  // Function to fetch brand products
  void getBrandProducts1({String? filter}) async {
    var idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    // Retrieve FilterController instance
    // final FilterController filterController = Get.find<FilterController>();

    // Get the `finalFilter` value
    // ignore: unused_local_variable
    // Map<String, List<dynamic>>? finalFilters;
    // if (filterController.selectedFilters.isNotEmpty) {
    //   finalFilters = {
    //     "filters": filterController.selectedFilters.entries.map((entry) {
    //       return {
    //         "type": entry.key,
    //         "values": entry.value.map((e) => e.toString()).toList()
    //       };
    //     }).toList()
    //   };
    // }

    // Create BrandProductModel with or without filters based on availability
    BrandProductModel2 brandProductModel = BrandProductModel2(
        id: idToken.$1,
        token: idToken.$2,
        by: by,
        value: value,
        filters: filter);

    try {
      final response =
          await authService.brandbaseProduct(brandProductModel.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          brandproductResponse.value = BrandReponseModel.fromJson(responseData);

          print(brandproductResponse.value);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to retrieve products',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load products: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
