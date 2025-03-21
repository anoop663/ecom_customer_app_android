// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
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
import '../../cart/controller/cart_controller.dart';
import '../model/payment_callback_model.dart';

class CheckoutScreenController extends GetxController {
  final addressTileOpen = false.obs;

  late var selectedAddress = Address().obs;
  final cartResponse1 = Rxn<CartResponse>();

  final loading = false.obs;
  final cartLoading = false.obs;
  final checkOutResponse = Rxn<CheckoutResponse>();
  final addressResponse2 = Rxn<AddressListResponse>();
  final paymentMode = (-1).obs;
  RxInt selectedMode=4.obs;
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
  void onInit() {
    print('init calling');
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
    log('........loading...');
    await getAddressFunction1();
    await getCheckOut();
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
      selectedAddress.value = Address();
      final response = await authService
          .getAddress(authData5.toJson())
          .timeout(const Duration(seconds: 15));
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
          log('default address iss---${jsonEncode(defaultAddress)}');
          if (defaultAddress != null) {
            selectedAddress.value = (defaultAddress.id == null
                ? addressResponse2.value?.addresses?.first
                : defaultAddress)!;
            log('selectedAddress address iss---${jsonEncode(selectedAddress.value)}');
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
    print('ondeadae---');
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

  // var onlinePaymentResponse;
  void checkOut() async {
    // print('payment mode --${paymentMode.value}');
    var idToken = storageProvider.readLoginDetails();
    CheckoutModel authData5 = CheckoutModel(
      id: idToken.$1,
      token: idToken.$2,
      billingaddressId: selectedAddress.value.id?.toString(),
      shippingaddressId: selectedAddress.value.id?.toString(),
      paymentMode: paymentMode.value.toString(),
    );

    
    print('checkOutResponse.value===${authData5.toJson()}');
    if (paymentMode.value == -1) {
      appToast('', 'Select a payment mode to continue');
    } else {
      if (paymentMode.value == 2) {
        loading.value = true;
        final response = await authService.chekOut(authData5.toJson());
        loading.value = false;
        if (response.statusCode == 200) {
          final responseData1 = json.decode(response.body);
          if (responseData1['success'] == 1) {
            checkOutResponse.value = CheckoutResponse.fromJson(responseData1);
            createOrderId(
              amount: (double.parse(
                      checkOutResponse.value?.orderId!.orderNetTotalAmount ??
                          ''))
                  .toInt(),
              id: checkOutResponse.value?.orderId?.id,
              description: checkOutResponse.value?.orderId?.invoiceNumber,
              userId: checkOutResponse.value?.orderId?.customerId,
              email: checkOutResponse.value?.orderId?.billingEmail,
              contact: checkOutResponse.value?.orderId?.billingPhone,
              name: checkOutResponse.value?.orderId?.billingName,
            );
            loading.value = false;
          } else {
            Get.snackbar(
                'Error', responseData1['message'] ?? 'Failed to list address',
                colorText: Colors.white, backgroundColor: Colors.black);
            loading.value = false;
          }
        } else {
          Get.snackbar('Error', 'Server error: ${response.statusCode}',
              colorText: Colors.white, backgroundColor: Colors.black);
          loading.value = false;
        }
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
              // clearCart();
              Get.find<CartController>().viewCart();
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

  final isLoading = false.obs;
  Future finalCheckOut(
      {String? status,
      PaymentFailureResponse? failureResponse,
      ExternalWalletResponse? walletResponse,
      PaymentSuccessResponse? successResponse}) async {
    var idToken = storageProvider.readLoginDetails();
    isLoading.value = true;
    FinalCheckoutModel finalCheckoutModel = FinalCheckoutModel(
      id: idToken.$1,
      token: idToken.$2,
      status: status,
      invoiceNumber: checkOutResponse.value?.orderId?.invoiceNumber,
      razorpay_payment_id: successResponse != null
          ? successResponse.data!['razorpay_payment_id']
          : failureResponse?.error!['metadata']['payment_id'],
    );
    // print(finalCheckoutModel.toJson());
    try {
      final response =
          await authService.finalCheckOut(body: finalCheckoutModel.toJson());
      if (response.statusCode == 200) {
        final responseData1 = json.decode(response.body);
        if (responseData1['success'] == 1) {
          if (status == 'success') {
            Get.offNamed(Routes.orderconfirm, arguments: {
              'order': checkOutResponse.value?.orderId,
            });
            Get.find<CartController>().viewCart();
          } else {
            Get.back();
          }
          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.snackbar(
              'Error', responseData1['message'] ?? 'Failed to list address',
              colorText: Colors.white, backgroundColor: Colors.black);
        }
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: Colors.white, backgroundColor: Colors.black);
      }
    } catch (e) {
      isLoading.value = false;
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
    print('PaymentSuccessResponse---${response.data}');
    print('PaymentSuccessResponse---${response.orderId}');
    print('PaymentSuccessResponse---${response.paymentId}');
    print('PaymentSuccessResponse---${response.signature}');
    finalCheckOut(successResponse: response, status: 'success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(' PaymentFailureResponse---${response.message}');
    print(' PaymentFailureResponse---${response.code}');
    print(' PaymentFailureResponse---${response.error}');

    finalCheckOut(failureResponse: response, status: 'failure');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(' ExternalWalletResponse---${response.walletName}');
    // finalCheckOut(razorPayResponce: response.walletName, status: 'failure');
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
    // ignore: non_constant_identifier_names
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
