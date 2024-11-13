import 'dart:convert';

CountryListResponse countryListResponseFromJson(String str) =>
    CountryListResponse.fromJson(json.decode(str));

String countryListResponseToJson(CountryListResponse data) =>
    json.encode(data.toJson());

class CountryListResponse {
  final int? success;
  final String? message;
  final List<Country>? countries;

  CountryListResponse({
    this.success,
    this.message,
    this.countries,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) =>
      CountryListResponse(
        success: json["success"],
        message: json["message"],
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
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
