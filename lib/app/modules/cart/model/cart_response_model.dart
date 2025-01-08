import 'dart:convert';

import 'package:soulstyle/app/modules/address_manage/model/address_response_model.dart';

import '../../home/models/home_product_model.dart';


CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  final int? success;
  final String? message;
  final List<Product>? products;
  final String? symbolLeft;
  final String? symbolRight;
  final String? grandTotal;
  final String? wallet;
  final String? tax;
  final String? deliveryCharge;
  final String? netTotal;
  final int? cartcount;
  final Address? shippingAddress;
  final Address? billingAddress;
  final String? walletMessage;
  final String? deliveryMessage;
  final List<Product>? recommendedProducts;
  final List<PaymentMode>? paymentModes;

  CartResponse({
    this.success,
    this.message,
    this.products,
    this.symbolLeft,
    this.symbolRight,
    this.grandTotal,
    this.wallet,
    this.deliveryCharge,
    this.netTotal,
    this.cartcount,
    this.shippingAddress,
    this.billingAddress,
    this.walletMessage,
    this.deliveryMessage,
    this.recommendedProducts,
    this.paymentModes,
    this.tax,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        success: json["success"],
        message: json["message"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        grandTotal: json["grand_total"],
        wallet: json["wallet"],
        tax: json["tax"].toString(),
        deliveryCharge: json["delivery_charge"].toString(),
        netTotal: json["net_total"],
        cartcount: json["cartcount"],
        shippingAddress: json["shipping_address"] != null
            ? Address.fromJson(json["shipping_address"])
            : null,
        billingAddress: json["billing_address"] == null
            ? null
            : Address.fromJson(json["billing_address"]),
        walletMessage: json["wallet_message"],
        deliveryMessage: json["delivery_message"],
        recommendedProducts: json["recommended_products"] == null
            ? []
            : List<Product>.from(
                json["recommended_products"]!.map((x) => Product.fromJson(x))),
        paymentModes: json["payment_modes"] == null
            ? []
            : List<PaymentMode>.from(
                json["payment_modes"]!.map((x) => PaymentMode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "products": products == null
            ? []
            : List<Product>.from(products!.map((x) => x.toJson())),
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
        "grand_total": grandTotal,
        "wallet": wallet,
        "tax": tax,
        "delivery_charge": deliveryCharge,
        "net_total": netTotal,
        "cartcount": cartcount,
        "shipping_address": shippingAddress,
        "billing_address": billingAddress,
        "wallet_message": walletMessage,
        "delivery_message": deliveryMessage,
        "recommended_products": recommendedProducts == null
            ? []
            : List<Product>.from(recommendedProducts!.map((x) => x)),
      };
}

class PaymentMode {
  final int? id;
  final String? mode;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentMode({
    this.id,
    this.mode,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
        id: json["id"],
        mode: json["mode"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mode": mode,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
