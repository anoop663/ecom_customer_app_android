import 'dart:convert';

AccountResponse accountResponseFromJson(String str) =>
    AccountResponse.fromJson(json.decode(str));

String accountResponseToJson(AccountResponse data) =>
    json.encode(data.toJson());

class AccountResponse {
  final int? success;
  final String? message;
  final String? phoneNumber;
  final String? gender;
  final String? name;
  final String? email;
  final dynamic photo;
  final int? referralHide;
  final int? ordersCount;
  final int? notificationCount;
  final int? wishlistCount;
  final int? addressCount;
  final int? mobileVerified;
  final int? emailVerified;
  final List<Social>? socials;
  final List<Social>? support;

  AccountResponse({
    this.success,
    this.message,
    this.phoneNumber,
    this.gender,
    this.name,
    this.email,
    this.photo,
    this.referralHide,
    this.ordersCount,
    this.notificationCount,
    this.wishlistCount,
    this.addressCount,
    this.mobileVerified,
    this.emailVerified,
    this.socials,
    this.support,
  });

  factory AccountResponse.fromRawJson(String str) =>
      AccountResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        success: json["success"],
        message: json["message"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        referralHide: json["referral_hide"],
        ordersCount: json["orders_count"],
        notificationCount: json["notification_count"],
        wishlistCount: json["wishlist_count"],
        addressCount: json["address_count"],
        mobileVerified: json["mobile_verified"],
        emailVerified: json["email_verified"],
        socials: json["socials"] == null
            ? []
            : List<Social>.from(
                json["socials"]!.map((x) => Social.fromJson(x))),
        support: json["support"] == null
            ? []
            : List<Social>.from(
                json["support"]!.map((x) => Social.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "phone_number": phoneNumber,
        "gender": gender,
        "name": name,
        "email": email,
        "photo": photo,
        "referral_hide": referralHide,
        "orders_count": ordersCount,
        "notification_count": notificationCount,
        "wishlist_count": wishlistCount,
        "address_count": addressCount,
        "mobile_verified": mobileVerified,
        "email_verified": emailVerified,
        "socials": socials == null
            ? []
            : List<dynamic>.from(socials!.map((x) => x.toJson())),
        "support": support == null
            ? []
            : List<dynamic>.from(support!.map((x) => x.toJson())),
      };
}

// class Social {
//   final String? fieldName;
//   final String? fieldValue;

//   Social({
//     this.fieldName,
//     this.fieldValue,
//   });

//   factory Social.fromRawJson(String str) => Social.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Social.fromJson(Map<String, dynamic> json) => Social(
//         fieldName: json["field_name"],
//         fieldValue: json["field_value"],
//       );

//   Map<String, dynamic> toJson() => {
//         "field_name": fieldName,
//         "field_value": fieldValue,
//       };
// }

class Social {
  final String? fieldName;
  final String? fieldValue;
  final String? image;
  final String? color;

  Social({
    this.fieldName,
    this.fieldValue,
    this.image,
    this.color,
  });

  factory Social.fromRawJson(String str) => Social.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        fieldName: json["field_name"],
        fieldValue: json["field_value"],
        image: json["image"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "field_name": fieldName,
        "field_value": fieldValue,
        "image": image,
        "color": color,
      };
}
