import 'dart:convert';

// To parse this JSON data, do
//
//     final filterResponse = filterResponseFromJson(jsonString);

FilterResponse filterResponseFromJson(String str) =>
    FilterResponse.fromJson(json.decode(str));

String filterResponseToJson(FilterResponse data) => json.encode(data.toJson());

class FilterResponse {
  final int? success;
  final String? message;
  final List<Filter>? filters;
  final Currency? currency;

  FilterResponse({
    this.success,
    this.message,
    this.filters,
    this.currency,
  });

  factory FilterResponse.fromJson(Map<String, dynamic> json) => FilterResponse(
        success: json["success"],
        message: json["message"],
        filters: json["filters"] == null
            ? []
            : List<Filter>.from(
                json["filters"]!.map((x) => Filter.fromJson(x))),
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "filters": filters == null
            ? []
            : List<dynamic>.from(filters!.map((x) => x.toJson())),
        "currency": currency?.toJson(),
      };
}

class Currency {
  final String? name;
  final String? code;
  final String? symbolLeft;
  final String? symbolRight;
  final String? value;
  final int? status;

  Currency({
    this.name,
    this.code,
    this.symbolLeft,
    this.symbolRight,
    this.value,
    this.status,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        value: json["value"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
        "value": value,
        "status": status,
      };
}

class Filter {
  final String? type;
  final String? text;
  final List<FilterValue>? values;

  Filter({
    this.type,
    this.text,
    this.values,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        type: json["type"],
        text: json["text"],
        values: json["values"] == null
            ? []
            : List<FilterValue>.from(
                json["values"]!.map((x) => FilterValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class XFilter {
  final String? type;
  final List<dynamic>? values;

  XFilter({
    this.type,
    this.values,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "values":
            values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
      };
}

class FilterValue {
  final String? filterValueId;
  final String? name;
  final int? parentId;

  FilterValue({
    this.filterValueId,
    this.name,
    this.parentId,
  });

  factory FilterValue.fromJson(Map<String, dynamic> json) => FilterValue(
        filterValueId: json["filter_value_id"].toString(),
        name: json["name"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "filter_value_id": filterValueId,
        "name": name,
        "parent_id": parentId,
      };
}
