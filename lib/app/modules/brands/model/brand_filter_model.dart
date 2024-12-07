// models/user_model.dart
import 'package:ecommerce_app/app/modules/brands/model/newfilter_model.dart';

class BrandProductModel2 {
  String? id;
  String? token;
  String? by;
  String? value;
  Filters? filters;

  BrandProductModel2({this.id, this.token, this.by, this.value, this.filters});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'by': by,
      'value': value,
      if(filters !=null)
      'filters': filters
    };
  }
}
