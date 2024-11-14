import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
import 'package:ecommerce_app/app/modules/checkout/model/checkout_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  final addressTileOpen = false.obs;

  final selectedAddress = Address().obs;
  final cartResponse1 = Rxn<CartResponse>();

  final loading = false.obs;
  final cartLoading = false.obs;
  final checkOutResponse = Rxn<CheckoutResponse>();
  final paymentMode = (-1).obs;
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  final scrollController = ScrollController();
  var cartItems = <Product>[].obs;
  var isRemoving = false.obs;
  var isMovingToWishlist = false.obs;
  var rebuildTrigger = false.obs;
  var cartModel = Rx<CartModel?>(null);
  

  @override
  @override
void onInit() {
  super.onInit();
  if (Get.arguments != null) {
    if (Get.arguments['cartResponse'] != null) {
      cartResponse1.value = Get.arguments['cartResponse'];
    }
  }
  //if (Get.arguments != null) {
    //  if (Get.arguments['address'] != null) {
    //    selectedAddress.value = Get.arguments['address'];
    //  }
    //  if (Get.arguments['cartResponse'] != null) {
    //    cartResponse.value = Get.arguments['cartResponse'];
    //  }
    //}
}
    
  

  @override
  void onReady() {
    super.onReady();
    getCheckOut();
  }

  void getCheckOut() async {

    
  }

  void checkout() async {}
}
