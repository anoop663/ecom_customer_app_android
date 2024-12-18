import 'dart:convert';



import '../../my_orders/model/myorders_response.dart';

OrderDetailResponse orderListResponseFromJson(String str) =>
    OrderDetailResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderDetailResponse data) =>
    json.encode(data.toJson());

class OrderDetailResponse {
  final int? success;
  final String? message;
  final Order? order;

  OrderDetailResponse({
    this.success,
    this.message,
    this.order,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        success: json["success"],
        message: json["message"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "order": order?.toJson(),
      };
}
