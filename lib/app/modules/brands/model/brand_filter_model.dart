// models/user_model.dart

class BrandProductModel2 {
  String? id;
  String? token;
  String? by;
  String? value;
  String? filters;

  BrandProductModel2({this.id, this.token, this.by, this.value, this.filters});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'by': by,
      'value': value,
      if (filters != null) 'filters': filters
    };
  }
}

class SortModel {
  String? id;
  String? token;
  String? from;
  String? value;
  String? sortBy;
  String? sortOrder;

  SortModel(
      {this.id,
      this.token,
      this.sortBy,
      this.value,
      this.from,
      this.sortOrder});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'by': from,
      'value': value,
      'sort_by': sortBy,
      'sort_order': sortOrder,
    };
  }
}
