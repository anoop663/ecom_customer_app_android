import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
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
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../core/values/constants.dart';

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
  late Razorpay razorpay;
  @override
  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

  Future _startInitialLoading() async {
    await getAddressFunction1();
    getCheckOut();
    Future.delayed(const Duration(seconds: 2), () {
      initialLoading.value = false;
    });
  }

  Future getAddressFunction1() async {
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
        log('responce iss---${json.decode(response.body)}');
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          addressResponse2.value = AddressListResponse.fromJson(responseData);
          final defaultAddress = addressResponse2.value?.addresses?.firstWhere(
            (address1) => address1.isDefault == 1,
            orElse: () => Address(),
          );
          if (defaultAddress != null) {
            selectedAddress.value = (defaultAddress.id == null
                ? addressResponse2.value?.addresses?.first
                : defaultAddress)!;
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
    // checkOut();
    // getCheckOut();
  }

//  void getCheckOut() async {}

  Future getCheckOut() async {
    final (String?, String?) idToken = storageProvider.readLoginDetails();
    loading.value = true;
    final CartModel homeAuth2 = CartModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: selectedAddress.value.id.toString(),
      shippingaddressId: selectedAddress.value.id.toString(),
      forwhat: 'checkout',
    );
    try {
      final response = await authService.viewtheCart(homeAuth2.toJson());
      loading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          cartResponse1.value = CartResponse.fromJson(responseData);
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

  var onlinePaymentResponse;
  void checkOut() async {
    print('payment mode --${paymentMode.value}');
    var idToken = storageProvider.readLoginDetails();
    CheckoutModel authData5 = CheckoutModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: selectedAddress.value.id?.toString(),
      shippingaddressId: selectedAddress.value.id?.toString(),
      paymentMode: paymentMode.value.toString(),
    );

    // ignore: avoid_print
    print('checkOutResponse.value===${authData5.toJson()}');
    if (paymentMode.value == -1) {
      appToast('', 'Select a payment mode to continue');
    } else {
      if (paymentMode.value == 2) {
        loading.value = true;
        print('online paymnet');
        onlinePaymentResponse = await authService.chekOut(authData5.toJson());
        log('onlione pay resionce is---${onlinePaymentResponse.body}');
        var data = jsonDecode(onlinePaymentResponse.body);
        createOrderId(
          amount: (double.parse(data['order_id']['order_net_total_amount']))
              .toInt(),
          id: data['order_id']['id'],
          description: data['order_id']['invoice_number'],
          userId: data['order_id']['customer_id'],
          email: data['order_id']['billing_email'],
          contact: data['order_id']['billing_phone'],
          name: data['order_id']['billing_name'],
        );
        loading.value = false;
      } else {
        loading.value = true;
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
    }
  }

  bool isLoadng = false;
  Future finalCheckOut({Map<String, dynamic>? body, String? status}) async {
    isLoadng = true;
    try {
      final response = await authService.finalCheckOut(body: body);
      isLoadng = false;
      if (response.statusCode == 200) {
        final responseData1 = json.decode(response.body);
        if (responseData1['success'] == 1) {
          if (status == 'success') {
            Get.offNamed(Routes.orderconfirm, arguments: {
              'order': checkOutResponse.value!.orderId,
            });
          }
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
      isLoadng = false;
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    var data = jsonDecode(onlinePaymentResponse.body);
    // ignore: avoid_print
    print('PaymentSuccessResponse---${response.data}');
    // ignore: avoid_print
    print('PaymentSuccessResponse---${response.orderId}');
    // ignore: avoid_print
    print('PaymentSuccessResponse---${response.paymentId}');
    // ignore: avoid_print
    print('PaymentSuccessResponse---${response.signature}');

    Map<String, dynamic> body = {
      'order_id': data['order_id']['id'],
      'status': 'success',
      'invoiceNumber': data['order_id']['invoice_number'],
      'razorPayResponce': response.data,
    };

    print('body is---${body}');
    finalCheckOut(body: body, status: 'success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    var data = jsonDecode(onlinePaymentResponse.body);
    // Do something when payment fails

    // ignore: avoid_print
    print(' PaymentFailureResponse---${response.message}');
    // ignore: avoid_print
    print(' PaymentFailureResponse---${response.code}');
    // ignore: avoid_print
    print(' PaymentFailureResponse---${response.error}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    var data = jsonDecode(onlinePaymentResponse.body);
    // Do something when an external wallet was selected
    // ignore: avoid_print
    print(' ExternalWalletResponse---${response.walletName}');
  }

  razorpayCheckOut(
      {num? amount,
      String? name,
      String? description,
      String? contact,
      String? email,
      String? orderId}) {
    var options = {
      'key': 'rzp_test_x2sOPOigQG6JQb',
      'amount': amount,
      'name': name,
      'description': description,
      'order_id': orderId,
      'prefill': {
        'contact': contact,
        'email': email,
      }
    };
    print('options ius----${options}');
    razorpay.open(options);
  }

  createOrderId({
    amount,
    description,
    id,
    userId,
    String? name,
    String? contact,
    String? email,
  }) async {
    final int Amount = ((amount ?? 0) * 100);
    http.Response response = await http.post(
        Uri.parse(
          "https://api.razorpay.com/v1/orders",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic ${base64Encode(utf8.encode('rzp_test_x2sOPOigQG6JQb:x0xZaWBazUZgCc1bkl2QbyJQ'))} "
        },
        body: json.encode({
          "amount": Amount,
          "currency": "INR",
          "receipt": "rcptid_$id",
          "notes": {"userId": "$userId", "packageId": "$id"},
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      razorpayCheckOut(
        amount: data['amount'],
        description: description,
        name: name,
        contact: contact,
        email: email,
        orderId: data['id'],
      );
    }
    print('responce is---${response.body}');
  }
}
