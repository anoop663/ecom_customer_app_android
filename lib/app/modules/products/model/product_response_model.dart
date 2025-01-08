import 'dart:convert';

import 'package:soulstyle/app/modules/home/models/home_product_model.dart';


ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) =>
    json.encode(data.toJson());

class ProductDetailsResponse {
  final int? success;
  final String? message;
  final Product? product;
  final dynamic enableGuestReview;
  final List<SelectedOption>? selectedOption;

  ProductDetailsResponse({
    this.success,
    this.message,
    this.product,
    this.enableGuestReview,
    this.selectedOption,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        success: json["success"],
        message: json["message"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        enableGuestReview: json["enable_guest_review"],
        selectedOption: json["selected_option"] == null
            ? []
            : List<SelectedOption>.from(json["selected_option"]!
                .map((x) => SelectedOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "product": product?.toJson(),
        "enable_guest_review": enableGuestReview,
        "selected_option": selectedOption == null
            ? []
            : List<dynamic>.from(selectedOption!.map((x) => x.toJson())),
      };
}

class SelectedOption {
  final int? optionValueId;
  final int? optionId;

  SelectedOption({
    this.optionValueId,
    this.optionId,
  });

  factory SelectedOption.fromJson(Map<String, dynamic> json) => SelectedOption(
        optionValueId: json["option_value_id"],
        optionId: json["option_id"],
      );

  Map<String, dynamic> toJson() => {
        "option_value_id": optionValueId,
        "option_id": optionId,
      };
}
