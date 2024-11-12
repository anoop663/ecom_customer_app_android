// models/user_model.dart
class AddressFunctionModel {
  String? id;
  String? token;
  String? addressid;

  AddressFunctionModel({this.id, this.token, this.addressid});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'address_id': id,
     
    };
  }
}
