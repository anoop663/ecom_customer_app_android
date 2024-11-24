import 'dart:convert';

SearchResponseModel searchResponseFromJson(String str) =>
    SearchResponseModel.fromJson(json.decode(str));

String searchResponseToJson(SearchResponseModel data) =>
    json.encode(data.toJson());

class SearchResponseModel {
  final int success;
  final String message;
  final List<Product> products;

  SearchResponseModel({
    required this.success,
    required this.message,
    required this.products,
  });

  // Factory constructor to create an instance from JSON
  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      success: json['success'] as int,
      message: json['message'] as String,
      products: (json['products'] as List<dynamic>)
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final String slug;
  final String name;
  final String type;

  Product({
    required this.slug,
    required this.name,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      slug: json['slug'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'type': type,
    };
  }
}
