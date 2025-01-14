import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/search/model/popular_search_response.dart';
import 'package:ecommerce_app/app/modules/search/model/search_model.dart';
import 'package:ecommerce_app/app/modules/search/model/search_response_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class SearchController1 extends GetxController {
  final loading = false.obs;
  final popularLoading = false.obs;
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  var sresponse = Rxn<SearchResponseModel>();
  final popularResponse = Rxn<PopularSearchResponse>();
  final searchController = TextEditingController();

  final List<String> list = [
    'T-Shirt',
    'Vests',
    'Printed T-shirts',
    'Oversized T-shirts',
    'Joggers',
    'New & Popular',
    'Bags'
  ];

  String? _lastQuery; // Cache for the last query

  @override
  void onInit() {
    super.onInit();
    getPopularSearches();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchData2(String query) async {
    if (query == _lastQuery) return; // Avoid duplicate API calls for the same query
    _lastQuery = query;

    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    SearchModel searchModel = SearchModel(
      id: idToken.$1,
      token: idToken.$2,
      query: query,
    );

    try {
      final response = await authService.searchFunction2(searchModel.toJson());
      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          sresponse.value = SearchResponseModel.fromJson(responseData);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to retrieve products',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load products: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }

  void getPopularSearches() async {
    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    HomeAuth popularSearchModel = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response1 =
          await authService.popsearchFunction1(popularSearchModel.toJson());

      loading.value = false;

      if (response1.statusCode == 200) {
        final responseData1 = json.decode(response1.body);

        if (responseData1['success'] == 1) {
          popularResponse.value = PopularSearchResponse.fromJson(responseData1);
        } else {
          Get.snackbar('Error',
              responseData1['message'] ?? 'Failed to retrieve products',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response1.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load products: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }
}
