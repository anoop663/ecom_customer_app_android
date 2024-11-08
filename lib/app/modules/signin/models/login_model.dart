// models/user_model.dart
class LoginModel {
  // ignore: non_constant_identifier_names
  String? email_phone;
  String? password;

  LoginModel({
    // ignore: non_constant_identifier_names
    this.email_phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email_phone': email_phone,
      'password': password,
    };
  }
}
