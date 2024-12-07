import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_model.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
import 'package:ecommerce_app/app/modules/checkout/model/checkout_model.dart';
import 'package:ecommerce_app/app/modules/checkout/model/checkout_response.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreenController extends GetxController {
  final addressTileOpen = false.obs;

  late var selectedAddress = Address().obs;
  final cartResponse1 = Rxn<CartResponse>();

  final loading = false.obs;
  final cartLoading = false.obs;
  final checkOutResponse = Rxn<CheckoutResponse>();
  final addressResponse2 = Rxn<AddressListResponse>();
  final paymentMode = (-1).obs;
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  final scrollController = ScrollController();
  var cartItems = <Product1>[].obs;
  var isRemoving = false.obs;
  var isMovingToWishlist = false.obs;
  var rebuildTrigger = false.obs;
  var cartModel = Rx<CartModel?>(null);
  var initialLoading = true.obs;
  var cartItems1 = <Product>[].obs;

  @override
  @override
  void onInit() {
    super.onInit();
    getAddressFunction1();
    _startInitialLoading();
    // getDefaultAddress();
    if (Get.arguments != null) {
      if (Get.arguments['cartResponse'] != null) {
        cartResponse1.value = Get.arguments['cartResponse'];
      }
    }

    //if (Get.arguments != null) {
    //    if (Get.arguments['address'] != null) {
    //      selectedAddress.value = Get.arguments['address'];
    //    }
    //    if (Get.arguments['cartResponse'] != null) {
    //      cartResponse.value = Get.arguments['cartResponse'];
    //    }
    //  }
  }

  void _startInitialLoading() {
    Future.delayed(const Duration(seconds: 5), () {
      initialLoading.value = false;
    });
  }

  void getAddressFunction1() async {
    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    HomeAuth authData5 = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response = await authService
          .getAddress(authData5.toJson())
          .timeout(const Duration(seconds: 5));

      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          addressResponse2.value = AddressListResponse.fromJson(responseData);
          final defaultAddress = addressResponse2.value?.addresses?.firstWhere(
            (address1) => address1.isDefault == 1,
            // orElse: () => null,
          );
          if (defaultAddress != null) {
            selectedAddress.value = defaultAddress;
          }
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to list address',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  @override
  void onReady() {
    checkOut();
    //   getCheckOut();
  }

//  void getCheckOut() async {}

  void checkOut() async {
    var idToken = storageProvider.readLoginDetails();
    loading.value = true;

    CheckoutModel authData5 = CheckoutModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: selectedAddress.value.id!.toString(),
      shippingaddressId: selectedAddress.value.id!.toString(),
      paymentMode: '-1',
    );

    try {
      final response = await authService.chekOut(authData5.toJson());

      loading.value = false;

      if (response.statusCode == 200) {
        final responseData1 = json.decode(response.body);

        if (responseData1['success'] == 1) {
          checkOutResponse.value = CheckoutResponse.fromJson(responseData1);

          Get.offNamed(Routes.orderconfirm, arguments: {
            'order': checkOutResponse.value!.orderId,
          });
          clearCart();
        } else {
          Get.snackbar(
              'Error', responseData1['message'] ?? 'Failed to list address',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to load address: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }

  void clearCart() async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    loading.value = true;

    final CartModel homeAuth2 = CartModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: selectedAddress.value.id!.toString(),
      shippingaddressId: selectedAddress.value.id!.toString(),
      forwhat: 'checkout',
    );

    try {
      final response = await authService.viewtheCart(homeAuth2.toJson());
      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartResponse1.value = CartResponse.fromJson(responseData);
          cartItems1.value = cartResponse1.value!.products!;
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Items viewing failed',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'Failed to view cart: $e',
          colorText: Colors.white, backgroundColor: Colors.black);
    }
  }
}
