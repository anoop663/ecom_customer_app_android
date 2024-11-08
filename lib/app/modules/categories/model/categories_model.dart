// models/user_model.dart
class CategoryProductModel {
  String? id;
  String? token;
  String? by;
  String? value;

  CategoryProductModel({
    this.id,
    this.token,
    this.by,
    this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'by': by,
      'value': value,
    };
  }
}
