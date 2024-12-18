import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

import '../../../core/extensions/api_base_helper.dart';
import '../../../data/api_provider.dart';
import '../../my_orders/my_order_repo/my_order_repo.dart';

class ConfirmCancelController extends GetxController {
  //TODO: Implement ConfirmCancelController

  final count = 0.obs;
  final confirm = false.obs;
  final isReturn = false.obs;
  final orderId = ''.obs;
  final itemId = ''.obs;
  final reason = ''.obs;
  final accountNumber = ''.obs;
  final accountName = ''.obs;
  final accountIfsc = ''.obs;
  final AuthService authService = AuthService();
  final MyOrderRepo myOrderRepo = MyOrderRepo();
  final loading = false.obs;
  final response = Rxn<Success>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['order_id'] != null) {
        orderId.value =
            Get.arguments['order_id'] ?? Get.arguments['item_id'] ?? '';
      }
      if (Get.arguments['item_id'] != null) {
        itemId.value = Get.arguments['item_id'];
      }
      if (Get.arguments['reason'] != null) {
        reason.value = Get.arguments['reason'];
      }
      if (Get.arguments['isReturn'] != null) {
        isReturn.value = Get.arguments['isReturn'] ?? false;
        if (isReturn.isTrue) {
          if (Get.arguments['account_number'] != null) {
            accountNumber.value = Get.arguments['account_number'];
          }
          if (Get.arguments['account_name'] != null) {
            accountName.value = Get.arguments['account_name'];
          }
          if (Get.arguments['ifsc'] != null) {
            accountIfsc.value = Get.arguments['ifsc'];
          }
        }
      }
    }
  }

  Future cancelOrder() async {
    loading.value = true;
    try {
      response.value = await myOrderRepo.cancelOrder(
        oderId: orderId.value,
        itemId: itemId.value,
        reason: reason.value,
      );
      confirm.value = true;
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


  Future returnOrder() async {
    loading.value = true;
    try {
      response.value = await myOrderRepo.returnOrder(
        orderId: orderId.value,
        itemId: itemId.value,
        reason: reason.value,
        accountName: accountName.value,
        accountNumber: accountNumber.value,
        ifsc: accountIfsc.value,
      );
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


  // void cancelOrder() async {
  //   loading(true);
  //   Either<Success, Failure> resp = await repository.cancelOrder(
  //     orderId: orderId.value,
  //     itemId: itemId.value,
  //     reason: reason.value,
  //   );
  //   resp.fold((l) {
  //     response(l);
  //     confirm.value = true;
  //     loading(false);
  //   }, (r) {
  //     appToast(r.code!, r.text!);
  //     loading(false);
  //   });
  // }

  // void returnOrder() async {
  //   loading(true);
  //   Either<Success, Failure> resp = await repository.returnOrder(
  //     orderId: orderId.value,
  //     itemId: itemId.value,
  //     reason: reason.value,
  //     accountName: accountName.value,
  //     accountNumber: accountNumber.value,
  //     ifsc: accountIfsc.value,
  //   );
  //   resp.fold((l) {
  //     response(l);
  //     confirm.value = true;
  //     loading(false);
  //   }, (r) {
  //     appToast(r.code!, r.text!);
  //     loading(false);
  //   });
  // }
}
