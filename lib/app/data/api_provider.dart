import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/api_constants.dart';
import 'package:ecommerce_app/app/core/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response?> postRequest(
      {required String url, dynamic body}) async {
    String uri = '${ApiConfig.apiUrl}$url';
    late http.Response response;
    try {
      response = await http.post(Uri.parse(uri), body: body ?? {});
      debugPrint("$uri------$body----->${response.body}--------");
      if (response.statusCode == 200) {
        return response;
      } else {
        Get.snackbar(
          'Error',
          'Server error: ${response.statusCode}',
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    } on SocketException {
      appToast('', 'No Internet connection');
    }
    return null;
  }

  Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.signup}'),
      body: userData,
    );
    return response;
  }

  Future<http.Response> verifyUser(Map<String, dynamic> verifyData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.verifyOtp}'),
      body: verifyData,
    );
    return response;
  }

  Future<http.Response> loginUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.login}'),
      body: userData,
    );
    return response;
  }

  Future<http.Response> resetOtp(Map<String, dynamic> forgotOtp) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.forgotMailSend}'),
      body: forgotOtp,
    );
    return response;
  }

  Future<http.Response> newPassword(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.resetPassword}'),
      body: userData,
    );
    return response;
  }

  Future<http.Response> homePage(Map<String, dynamic> authData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.home}'),
      body: authData,
    );
    return response;
  }

  Future<http.Response> brandbaseProduct(
      Map<String, dynamic> brandProducts) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.products}'),
      body: brandProducts,
    );
    debugPrint('body-----$brandProducts=====${jsonDecode(response.body)}');
    return response;
  }

  Future<http.Response> productFetch(
      Map<String, dynamic> productDetails, String productSlug) async {
    print(  '${ApiConfig.apiUrl}${ApiConstants.productDetails}/$productSlug');
    print(  '$productDetails');
    final response = await http.post(
      Uri.parse(
          '${ApiConfig.apiUrl}${ApiConstants.productDetails}/$productSlug'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(productDetails),
    );

    return response;
  }

  Future<http.Response> addToWishlist(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.addToWishlist}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> addToCart(Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.addToCart}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> showWishlist(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.wishlist}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> removeWishlist(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.moveToCart}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> viewtheCart(Map<String, dynamic> cartView) async {
    // print('cart--$cartView');
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.cart}'),
      body: cartView,
    );
    // ignore: avoid_print
    print('body is----$cartView----${jsonDecode(response.body)}-');
    return response;
  }

  Future<http.Response> moveToWishlist(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.moveToWishlist}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> logOut(Map<String, dynamic> authData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.logout}'),
      body: authData,
    );
    return response;
  }

  Future<http.Response> addAddress(Map<String, dynamic> addressDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.addAddress}'),
      body: addressDetails,
    );
    return response;
  }

  Future<http.Response> editAddress(Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.editAddress}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> updateAddress(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.editAddress}'),
      body: productDetails,
    );
    return response;
  }

  Future<http.Response> getAddress(Map<String, dynamic> authData) async {
    final url = '${ApiConfig.apiUrl}${ApiConstants.customerAddresses}';

    final response = await http.post(
      Uri.parse(url),
      body: authData,
    );

    return response;
  }

  Future<http.Response> removeAddress(Map<String, dynamic> authData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.removeAddress}'),
      body: authData,
    );
    return response;
  }

  Future<http.Response> searchFunction2(Map<String, dynamic> searchData) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.searchProducts}'),
      body: searchData,
    );
    return response;
  }

  Future<http.Response> popsearchFunction1(
      Map<String, dynamic> authData) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.popularSearches}';
    final response1 = await http.post(
      Uri.parse(url1),
      body: authData,
    );
    return response1;
  }

  Future<http.Response> filterData(Map<String, dynamic> authData) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.filter}';
    final response1 = await http.post(
      Uri.parse(url1),
      body: authData,
    );
    return response1;
  }

  Future<http.Response> chekOut(Map<String, dynamic> authData) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.checkout}';

    // Wait for 4 seconds before making the request
    // await Future.delayed(const Duration(seconds: 1));

    final response2 = await http.post(
      Uri.parse(url1),
      body: authData,
    );
    return response2;
  }

  Future<http.Response> finalCheckOut({
    Map<String, dynamic>? body,
  }) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.finalCheckout}';
    final response2 = await http.post(
      Uri.parse(url1),
      body: body,
    );
    return response2;
  }

  Future<http.Response> getAccountDetails(Map<String, dynamic> authData) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.accountDetails}';

    final response3 = await http.post(
      Uri.parse(url1),
      body: authData,
    );
    return response3;
  }

  Future<http.Response> getProfile(Map<String, dynamic> authData) async {
    final url1 = '${ApiConfig.apiUrl}${ApiConstants.profile}';

    final response4 = await http.post(
      Uri.parse(url1),
      body: authData,
    );
    return response4;
  }

  Future<http.Response> getPageContents(link) async {
    // ignore: unnecessary_brace_in_string_interps
    final url1 = '${ApiConfig.apiUrl}${link}';

    final response5 = await http.get(
      Uri.parse(url1),
      // body: authData,
    );
    return response5;
  }
}
