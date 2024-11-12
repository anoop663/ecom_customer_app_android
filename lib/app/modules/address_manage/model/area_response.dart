import 'dart:convert';

class AreaResponse {
  final int? success;
  final Result? result;
  final String? message;

  AreaResponse({
    this.success,
    this.result,
    this.message,
  });

  factory AreaResponse.fromRawJson(String str) =>
      AreaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AreaResponse.fromJson(Map<String, dynamic> json) => AreaResponse(
        success: json["success"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": result?.toJson(),
        "message": message,
      };
}

class Result {
  final List<Region>? regions;

  Result({
    this.regions,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        regions: json["regions"] == null
            ? []
            : List<Region>.from(
                json["regions"]!.map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regions": regions == null
            ? []
            : List<dynamic>.from(regions!.map((x) => x.toJson())),
      };
}

class Region {
  final String? regionName;
  final List<Area>? areas;

  Region({
    this.regionName,
    this.areas,
  });

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionName: json["Region Name"],
        areas: json["Areas"] == null
            ? []
            : List<Area>.from(json["Areas"]!.map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Region Name": regionName,
        "Areas": areas == null
            ? []
            : List<dynamic>.from(areas!.map((x) => x.toJson())),
      };
}

class Area {
  final int? code;
  final String? areaName;

  Area({
    this.code,
    this.areaName,
  });

  factory Area.fromRawJson(String str) => Area.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        code: json["Code"],
        areaName: json["Area Name"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Area Name": areaName,
      };
}
