// models/user_model.dart
class AddressCreateModel {
  String? id;
  String? token;
  String? name;
  String? city;
  String? buildingnumber;
  String? country;
  String? mobile;
  String? area;
  String? zipcode;
  String? addresstype;
  String? isDefault;

  AddressCreateModel({
    this.id,
    this.token,
    this.name,
    this.city,
    this.buildingnumber,
    this.addresstype,
    this.area,
    this.country,
    this.mobile,
    this.zipcode,
    this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'city': city,
      'building_number': buildingnumber,
      'country': country,
      'mobile': mobile,
      'area_number': area,
      'zipcode': zipcode,
      'address_type': addresstype,
      'isDefault' : isDefault,
    };
  }
}
