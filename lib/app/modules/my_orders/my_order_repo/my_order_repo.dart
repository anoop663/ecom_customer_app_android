import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/extensions/api_base_helper.dart';
import '../../../core/values/api_constants.dart';
import '../../../data/api_provider.dart';
import '../../../data/storage_provider.dart';
import '../../single_order_details/models/order_details_response.dart';
import '../../single_order_details/models/track_response.dart';
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

  Future<Success?> cancelOrder(
      {String? oderId, String? reason, String? itemId}) async {
    final idToken = storageProvider.readLoginDetails();
    http.Response? response;
    response = await authService.postRequest(
      url:
          '${ApiConstants.cancelOrder}?id=${idToken.$1}&token=${idToken.$2}&order_id=$oderId&reason=$reason&type=item&item_id=$itemId',
      body: {},
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return Success.fromJson(json.decode(response.body));
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

  Future<Success?> returnOrder({
    String? orderId,
    String? itemId,
    String? reason,
    String? accountName,
    String? accountNumber,
    String? ifsc,
  }) async {
    final idToken = storageProvider.readLoginDetails();
    http.Response? response;
    var body = {
      "id": idToken.$1 ?? '',
      "token": idToken.$2 ?? '',
      "item_id": itemId ?? '',
      "order_id": orderId ?? '',
      "reason": reason ?? '',
      "type": 'item',
      "fullname": accountName,
      "account_no": accountNumber,
      "ifsc": ifsc,
      "bank": '',
      "branch": '',
    };
    response = await authService.postRequest(
      url: ApiConstants.returnItem,
      body: body,
    );
    if (response != null) {
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == 1) {
        return Success.fromJson(json.decode(response.body));
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
