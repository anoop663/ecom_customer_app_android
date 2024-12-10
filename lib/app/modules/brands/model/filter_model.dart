// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  List<Filter>? filters;

  FilterModel({
    this.filters,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        filters: json["filters"] == null
            ? []
            : List<Filter>.from(
                json["filters"]!.map((x) => Filter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "filters": filters == null
            ? []
            : List<dynamic>.from(filters!.map((x) => x.toJson())),
      };
}

class Filter {
  String? type;
  List<int>? values;

  Filter({
    this.type,
    this.values,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        type: json["type"],
        values: json["values"] == null
            ? []
            : List<int>.from(json["values"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "values":
            values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
      };
}
