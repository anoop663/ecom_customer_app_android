import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

import '../../../data/storage_provider.dart';
import '../../home/models/home_product_model.dart';
import '../../my_orders/model/myorders_response.dart' as orderlist;

import '../../../data/api_provider.dart';
import '../../my_orders/model/myorders_response.dart';
import '../../my_orders/my_order_repo/my_order_repo.dart';
import '../models/order-details-response.dart';
import '../models/track-response.dart';

class SingleOrderDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late final AnimationController tickcontroller;
  final loading = false.obs;
  final AuthService authService = AuthService();
  final MyOrderRepo myOrderRepo = MyOrderRepo();
  final response = Rxn<OrderDetailResponse>();
  final trackResponse = Rxn<TrackResponse>();
  final StorageProvider storageProvider = StorageProvider();
  final order = Rxn<orderlist.Order>();
  final item = Rxn<orderlist.ItemsNew>();

  @override
  void onInit() {
    super.onInit();
    tickcontroller = AnimationController(
      vsync: this,
      value: 1,
    );
    if (Get.arguments != null) {
      if (Get.arguments['order'] != null) {
        order.value = Get.arguments['order'];
        if (Get.arguments['item'] != null) {
          item.value = Get.arguments['item'];
          getTracking();
        }
        getOrderDetails();
      }
    }
  }

  Future getOrderDetails() async {
    loading.value = true;
    try {
      response.value = await myOrderRepo.getOrderDetails(
          invoiceNumber: order.value!.invoiceNumber!);
      order.value = response.value?.order!;
      print('possible action${item.value!.possibleAction!}');
      for (var element in response.value!.order!.items!) {
        if (element.id == item.value!.id) {
          item.value = element;
          print('possible action${item.value!.possibleAction!}');
        }
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load orders: $e',
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  Future getTracking() async {
    final idToken = storageProvider.readLoginDetails();
    loading.value = true;
    var body = {
      "id": idToken.$1 ?? '',
      "token": idToken.$2 ?? '',
      "item_id": item.value!.id!.toString(),
    };
    try {
      trackResponse.value =
          await myOrderRepo.getTracking(itemId: item.value!.id!.toString());
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load orders: $e',
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

// void getOrderDetails() async {
//   loading(true);
//   Either<OrderDetailResponse, Failure> resp =
//       await repository.getOrderDetails(
//     orderId: order.value!.invoiceNumber!,
//   );
//   resp.fold((l) {
//     response(l);
//     order.value = l.order!;
//     print('possible action${item.value!.possibleAction!}');
//     for (var element in response.value!.order!.items!) {
//       if (element.id == item.value!.id) {
//         item.value = element;
//         print('possible action${item.value!.possibleAction!}');
//       }
//     }
//
//     loading(false);
//   }, (r) {
//     appToast(r.code!, r.text!);
//     loading(false);
//   });
// }

// void getTracking() async {
//   loading(true);
//   Either<TrackResponse, Failure> resp = await repository.getTracking(
//     itemId: item.value!.id!.toString(),
//   );
//   resp.fold((l) {
//     trackResponse(l);
//     loading(false);
//   }, (r) {
//     appToast(r.code!, r.text!);
//     loading(false);
//   });
// }
}
