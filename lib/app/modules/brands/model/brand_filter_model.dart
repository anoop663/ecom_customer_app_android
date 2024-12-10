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
