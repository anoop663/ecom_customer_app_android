
import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());
    
class ProfileResponse {
  final int success;
  final String message;
  final CustomerData? customerData;

  ProfileResponse({
    required this.success,
    required this.message,
    this.customerData,
  });

  // Factory constructor to create a ProfileResponse from JSON
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      customerData: json['customerdata'] != null
          ? CustomerData.fromJson(json['customerdata'])
          : null,
    );
  }

  // Convert a ProfileResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'customerdata': customerData?.toJson(),
    };
  }
}

class CustomerData {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String gender;
  final String? referee;
  final String referralCode;
  final int referralHide;
  final int status;
  final int notificationCount;
  final int wishlistCount;
  final int addressCount;
  final int otpVerificationStatus;
  final int emailVerificationStatus;

  CustomerData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    this.referee,
    required this.referralCode,
    required this.referralHide,
    required this.status,
    required this.notificationCount,
    required this.wishlistCount,
    required this.addressCount,
    required this.otpVerificationStatus,
    required this.emailVerificationStatus,
  });

  // Factory constructor to create a CustomerData from JSON
  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      gender: json['gender'] ?? '',
      referee: json['referee'],
      referralCode: json['referral_code'] ?? '',
      referralHide: json['referral_hide'] ?? 0,
      status: json['status'] ?? 0,
      notificationCount: json['notification_count'] ?? 0,
      wishlistCount: json['wishlist_count'] ?? 0,
      addressCount: json['address_count'] ?? 0,
      otpVerificationStatus: json['otpverificationstatus'] ?? 0,
      emailVerificationStatus: json['emailverificationstatus'] ?? 0,
    );
  }

  // Convert a CustomerData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'gender': gender,
      'referee': referee,
      'referral_code': referralCode,
      'referral_hide': referralHide,
      'status': status,
      'notification_count': notificationCount,
      'wishlist_count': wishlistCount,
      'address_count': addressCount,
      'otpverificationstatus': otpVerificationStatus,
      'emailverificationstatus': emailVerificationStatus,
    };
  }
}
