import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/constants.dart';
import '../../my_orders/model/myorders_response.dart';


class CancelOrderController extends GetxController {
  final count = 0.obs;

  ///need to change reasons to dynamic values from response
  final reasons = <String>[
    'Want to change the style/color',
    'Want to change the size',
    'Want to change address/phone number',
    'Want to change the payment method',
    'Product won’t reach on time',
    'Other',
  ].obs;
  final commentController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountIFSCcontroller = TextEditingController();
  final accountNumbercontroller = TextEditingController();
  final selectedReason = ''.obs;
  final order = Rxn<Order>();
  final item = Rxn<ItemsNew>();
  final isReturn = false.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['order'] != null) {
        order.value = Get.arguments['order'];
      }
      if (Get.arguments['item'] != null) {
        item.value = Get.arguments['item'];
      }
      if (Get.arguments['isReturn'] != null) {
        isReturn.value = Get.arguments['isReturn'] ?? false;
        if (isReturn.isTrue) {
          reasons.value = [
            'The customer ordered the wrong product or size',
            'The merchant shipped the wrong product or size',
            'The product was damaged or defective',
            'The product arrived too late',
            'The product did not match the description',
            'Other',
          ];
        }
      }
    }
  }



  bool validate() {
    if (isReturn.isTrue) {
      if (accountNameController.text.isEmpty) {
        appToast('', 'Account Name is mandatory for returning an item');
        return false;
      }
      if (accountNumbercontroller.text.isEmpty) {
        appToast('', 'Account Number is mandatory for returning an item');
        return false;
      }
      if (accountIFSCcontroller.text.isEmpty) {
        appToast('', 'IFSC code is mandatory for returning an item');
        return false;
      }
    }
    return true;
  }
}
