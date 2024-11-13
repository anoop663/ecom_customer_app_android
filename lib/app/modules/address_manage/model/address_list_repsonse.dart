import 'dart:convert';

AddressListResponse addressListResponseFromJson(String str) =>
    AddressListResponse.fromJson(json.decode(str));

String addressListResponseToJson(AddressListResponse data) =>
    json.encode(data.toJson());

class AddressListResponse {
  final int? success;
  final String? message;
  final List<Address>? addresses;

  AddressListResponse({
    this.success,
    this.message,
    this.addresses,
  });

  factory AddressListResponse.fromJson(Map<String, dynamic> json) =>
      AddressListResponse(
        success: json["success"],
        message: json["message"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Address {
  final int? id;
  final int? customerId;
  final String? name;
  final dynamic address;
  final String? buildingNumber;
  final String? areaNumber;
  final dynamic streetNumber;
  final String? city;
  final String? state;
  final int? countryId;
  final String? zipcode;
  final String? mobile;
  final String? addressType;
  final dynamic latitude;
  final dynamic longtitude;
  final int? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Country? country;

  Address({
    this.id,
    this.customerId,
    this.name,
    this.address,
    this.buildingNumber,
    this.areaNumber,
    this.streetNumber,
    this.city,
    this.state,
    this.countryId,
    this.zipcode,
    this.mobile,
    this.addressType,
    this.latitude,
    this.longtitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        customerId: json["customer_id"],
        name: json["name"],
        address: json["address"],
        buildingNumber: json["building_number"],
        areaNumber: json["area_number"],
        streetNumber: json["street_number"],
        city: json["city"],
        state: json["state"] ?? '',
        countryId: json["country_id"],
        zipcode: json["zipcode"],
        mobile: json["mobile"],
        addressType: json["address_type"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "name": name,
        "address": address,
        "building_number": buildingNumber,
        "area_number": areaNumber,
        "street_number": streetNumber,
        "city": city,
        "state": state,
        "country_id": countryId,
        "zipcode": zipcode,
        "mobile": mobile,
        "address_type": addressType,
        "latitude": latitude,
        "longtitude": longtitude,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "country": country?.toJson(),
      };
}

class Country {
  final int? id;
  final String? name;
  final String? shortcode;
  final int? dialCode;
  final int? deliveryAvailable;
  final dynamic createdAt;
  final DateTime? updatedAt;

  Country({
    this.id,
    this.name,
    this.shortcode,
    this.dialCode,
    this.deliveryAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        shortcode: json["shortcode"],
        dialCode: json["dial_code"],
        deliveryAvailable: json["delivery_available"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortcode": shortcode,
        "dial_code": dialCode,
        "delivery_available": deliveryAvailable,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
