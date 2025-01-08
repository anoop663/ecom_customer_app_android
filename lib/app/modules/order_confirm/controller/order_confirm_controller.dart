import 'package:soulstyle/app/modules/checkout/model/checkout_response.dart';
import 'package:get/get.dart';


class OrderConfirmScreenController extends GetxController {
  final order = Rxn<OrderId>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['order'] != null) {
        order.value = Get.arguments['order'];
      }
    }
  }



  void increment() => count.value++;
}
