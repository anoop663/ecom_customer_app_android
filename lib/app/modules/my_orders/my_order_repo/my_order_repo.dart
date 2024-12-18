import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/values/api_constants.dart';
import '../../../data/api_provider.dart';
import '../../../data/storage_provider.dart';
import '../../singleOrderDetails/models/order-details-response.dart';
import '../../singleOrderDetails/models/track-response.dart';
import '../model/myorders_response.dart' as myorder;

class MyOrderRepo {
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  Future<myorder.OrderListResponse?> myOrder(var body) async {
    http.Response? response;
    response = await authService.postRequest(
      url: ApiConstants.orders,
      body: body,
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return myorder.orderListResponseFromJson(response.body);
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

  Future<TrackResponse?> getTracking({String? itemId}) async {
    final idToken = storageProvider.readLoginDetails();
    http.Response? response;
    response = await authService.postRequest(
      url:
          '${ApiConstants.track}?id=${idToken.$1}&token=${idToken.$2}&item_id=$itemId',
      body: {},
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return trackResponseFromJson(response.body);
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

  Future<OrderDetailResponse?> getOrderDetails({String? invoiceNumber}) async {
    final idToken = storageProvider.readLoginDetails();
    http.Response? response;
    response = await authService.postRequest(
      url:
          '${ApiConstants.orderDetails}?id=${idToken.$1}&token=${idToken.$2}&invoice_number=$invoiceNumber',
      body: {},
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return OrderDetailResponse.fromJson(json.decode(response.body));
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
