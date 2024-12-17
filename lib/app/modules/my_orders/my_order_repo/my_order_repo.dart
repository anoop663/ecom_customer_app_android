import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../core/values/api_constants.dart';
import '../../../data/api_provider.dart';
import '../model/myorders_response.dart';

class MyOrderRepo {
  final AuthService authService = AuthService();

  Future<OrderListResponse?> myOrder(var body) async {
    http.Response? response;
    response = await authService.postRequest(
      url: ApiConstants.orders,
      body: body,
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return orderListResponseFromJson(response.body);
      } else {
        Get.snackbar(
          'Error',
          responseData['message'] ?? 'Failed to retrieve orders',
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        return null;
      }
    }
    return null;
  }
}
