// models/user_model.dart
class UserModel {
  String? name;
  String? email;
  String? phoneCountryCode;
  String? phoneNumber;
  String? password;
  String? gender;

  UserModel({
    this.name,
    this.email,
    this.phoneCountryCode,
    this.phoneNumber,
    this.password,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_country_code': phoneCountryCode,
      'phone_number': phoneNumber,
      'password': password,
      'gender': gender,
    };
  }
}
