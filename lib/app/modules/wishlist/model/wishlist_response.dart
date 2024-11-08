class WishListResponse {
  final int success;
  final String message;
  final List<Product> products;

  WishListResponse({
    required this.success,
    required this.message,
    required this.products,
  });

  // fromJson method for deserializing JSON data
  factory WishListResponse.fromJson(Map<String, dynamic> json) {
    return WishListResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  // toJson method for serializing data to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class Product {
  final int id;
  final String slug;
  final String code;
  final String name;
  final String description;
  final String appDescription;
  final String date;
  final int storeId;
  final String storeSlug;
  final String store;
  final String manufacturer;
  final String value;
  final String symbolLeft;
  final String symbolRight;
  final int quantity;
  final String oldPrice;
  final String price;
  final String discount;
  final String rating;
  final String image;
  final int wishlist;
  final int cart;

  Product({
    required this.id,
    required this.slug,
    required this.code,
    required this.name,
    required this.description,
    required this.appDescription,
    required this.date,
    required this.storeId,
    required this.storeSlug,
    required this.store,
    required this.manufacturer,
    required this.value,
    required this.symbolLeft,
    required this.symbolRight,
    required this.quantity,
    required this.oldPrice,
    required this.price,
    required this.discount,
    required this.rating,
    required this.image,
    required this.wishlist,
    required this.cart,
  });

  // fromJson method for deserializing JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      appDescription: json['app_description'] ?? '',
      date: json['date'] ?? '',
      storeId: json['store_id'] ?? 0,
      storeSlug: json['storeslug'] ?? '',
      store: json['store'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      value: json['value'] ?? '',
      symbolLeft: json['symbol_left'] ?? '',
      symbolRight: json['symbol_right'] ?? '',
      quantity: json['quantity'] ?? 0,
      oldPrice: json['oldprice'] ?? '',
      price: json['price'] ?? '',
      discount: json['discount'] ?? '',
      rating: json['rating'] ?? '',
      image: json['image'] ?? '',
      wishlist: json['wishlist'] ?? 0,
      cart: json['cart'] ?? 0,
    );
  }

  // toJson method for serializing data to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'code': code,
      'name': name,
      'description': description,
      'app_description': appDescription,
      'date': date,
      'store_id': storeId,
      'storeslug': storeSlug,
      'store': store,
      'manufacturer': manufacturer,
      'value': value,
      'symbol_left': symbolLeft,
      'symbol_right': symbolRight,
      'quantity': quantity,
      'oldprice': oldPrice,
      'price': price,
      'discount': discount,
      'rating': rating,
      'image': image,
      'wishlist': wishlist,
      'cart': cart,
    };
  }
}
