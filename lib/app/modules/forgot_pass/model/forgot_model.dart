// models/user_model.dart
class ForgotModel {
  String? email;

  ForgotModel({
    this.email,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
