// models/user_model.dart
class AddressRemoveModel {
  String? id;
  String? token;
  String? addressid;

  AddressRemoveModel({this.id, this.token, this.addressid});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'address_id': id,
     
    };
  }
}
