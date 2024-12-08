import 'dart:convert';

class PageContentResponse {
  final int? success;
  final String? message;
  final List<Pagecontent>? pagecontents;
  final String? page;

  PageContentResponse({
    this.success,
    this.message,
    this.pagecontents,
    this.page,
  });

  factory PageContentResponse.fromRawJson(String str) =>
      PageContentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PageContentResponse.fromJson(Map<String, dynamic> json) =>
      PageContentResponse(
        success: json["success"],
        message: json["message"],
        pagecontents: json["pagecontents"] == null
            ? []
            : List<Pagecontent>.from(
                json["pagecontents"]!.map((x) => Pagecontent.fromJson(x))),
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagecontents": pagecontents == null
            ? []
            : List<dynamic>.from(pagecontents!.map((x) => x.toJson())),
        "page": page,
      };
}

class Pagecontent {
  final int? id;
  final String? page;
  final String? languageCode;
  final String? fieldName;
  final String? fieldValue;
  final String? fieldType;
  final dynamic fieldWidth;
  final String? fieldCaption;
  final dynamic fieldHeight;
  final int? status;
  final dynamic createdAt;
  final DateTime? updatedAt;

  Pagecontent({
    this.id,
    this.page,
    this.languageCode,
    this.fieldName,
    this.fieldValue,
    this.fieldType,
    this.fieldWidth,
    this.fieldCaption,
    this.fieldHeight,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Pagecontent.fromRawJson(String str) =>
      Pagecontent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagecontent.fromJson(Map<String, dynamic> json) => Pagecontent(
        id: json["id"],
        page: json["page"],
        languageCode: json["language_code"],
        fieldName: json["field_name"],
        fieldValue: json["field_value"],
        fieldType: json["field_type"],
        fieldWidth: json["field_width"],
        fieldCaption: json["field_caption"],
        fieldHeight: json["field_height"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "language_code": languageCode,
        "field_name": fieldName,
        "field_value": fieldValue,
        "field_type": fieldType,
        "field_width": fieldWidth,
        "field_caption": fieldCaption,
        "field_height": fieldHeight,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
