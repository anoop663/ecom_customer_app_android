import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/my_orders/model/myorders_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  final isLoading = false.obs;
  final response = Rxn<OrderListResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();

  @override
  void onInit() {
    super.onInit();
    getOrders(); 
  }

  void getOrders() async {
    final idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    final homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final apiResponse = await authService.brandbaseProduct(homeAuth.toJson());
      isLoading.value = false;

      if (apiResponse.statusCode == 200) {
        final responseData = json.decode(apiResponse.body);

        if (responseData['success'] == 1) {
          response.value = OrderListResponse.fromJson(responseData);
          
        } else {
          Get.snackbar(
            'Error',
            responseData['message'] ?? 'Failed to retrieve orders',
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${apiResponse.statusCode}',
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load orders: $e',
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }
}
