import 'package:get/get.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}
