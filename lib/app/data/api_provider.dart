import 'dart:convert';

import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
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
    return response;
  }

  Future<http.Response> productFetch(
      Map<String, dynamic> productDetails, String productSlug) async {
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
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.cart}'),
      body: cartView,
    );
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

  Future<http.Response> addAddress(Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.addAddress}'),
      body: productDetails,
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

  Future<http.Response> deleteAddress(
      Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.removeAddress}'),
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

  Future<http.Response> listAddress(Map<String, dynamic> productDetails) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.apiUrl}${ApiConstants.customerAddresses}'),
      body: productDetails,
    );
    return response;
  }
}
