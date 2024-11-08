import 'dart:convert';

// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final int? success;
  final String? message;
  final Customerdata? customerdata;
  final String? guest;

  LoginResponse({
    this.success,
    this.message,
    this.customerdata,
    this.guest,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        guest: json["guest"],
        customerdata: json["customerdata"] == null
            ? null
            : Customerdata.fromJson(json["customerdata"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "guest": guest,
        "customerdata": customerdata?.toJson(),
      };
}

class Customerdata {
  final String? id;
  final String? token;
  final String? name;
  final String? email;
  final String? mobile;
  final String? gender;
  final String? referee;
  final String? referralCode;
  final int? referralHide;
  final int? status;
  final int? notificationCount;
  final int? wishlistCount;
  final int? addressCount;
  final int? otpverificationstatus;
  final int? emailverificationstatus;

  Customerdata({
    this.id,
    this.token,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.referee,
    this.referralCode,
    this.referralHide,
    this.status,
    this.notificationCount,
    this.wishlistCount,
    this.addressCount,
    this.otpverificationstatus,
    this.emailverificationstatus,
  });

  factory Customerdata.fromJson(Map<String, dynamic> json) => Customerdata(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
        referee: json["referee"],
        referralCode: json["referral_code"],
        referralHide: json["referral_hide"],
        status: json["status"],
        notificationCount: json["notification_count"],
        wishlistCount: json["wishlist_count"],
        addressCount: json["address_count"],
        otpverificationstatus: json["otpverificationstatus"],
        emailverificationstatus: json["emailverificationstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "referee": referee,
        "referral_code": referralCode,
        "referral_hide": referralHide,
        "status": status,
        "notification_count": notificationCount,
        "wishlist_count": wishlistCount,
        "address_count": addressCount,
        "otpverificationstatus": otpverificationstatus,
        "emailverificationstatus": emailverificationstatus,
      };
}
