class NewPassModel {
  String? code;
  String? password;
  String? email;

  NewPassModel({
    this.code,
    this.password,
    this.email,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'code' : code,
      'password': password,
      'email': email,
    };
  }
}
