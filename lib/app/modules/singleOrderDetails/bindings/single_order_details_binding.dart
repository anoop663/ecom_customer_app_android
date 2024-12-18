import 'package:get/get.dart';

import '../controllers/single_order_details_controller.dart';

class SingleOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleOrderDetailsController>(
      () => SingleOrderDetailsController(),
    );
  }
}
