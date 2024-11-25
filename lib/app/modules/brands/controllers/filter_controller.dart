import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/brands/model/filter_response_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final isLoading = false.obs;
  final fliterResponse = Rxn<FilterResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  @override
  void onInit() {
    super.onInit();
    getFilters();
  }

  Map filterList = {};
  final categories = <FilterValue>[].obs;
  final sizes = <FilterValue>[].obs;
  final colors = <FilterValue>[].obs;
  final minPrice = ''.obs;
  final maxPrice = ''.obs;
  List discounts = [];

  final selectedFilters = <String, List<dynamic>>{}.obs;

  final currentSelected = Rxn<Filter>();

  void getFilters() async {
    var idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    HomeAuth homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,

    );

    try {
      final response =
          await authService.filterData(homeAuth.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          fliterResponse.value = FilterResponse.fromJson(responseData);
         
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
