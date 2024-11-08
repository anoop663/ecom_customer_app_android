// models/user_model.dart
class OtpModel {
  String? id;
  String? otp;

  OtpModel({
    this.id,
    this.otp,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'otp': otp,
    };
  }
}
