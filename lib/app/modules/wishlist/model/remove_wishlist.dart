// models/user_model.dart
class RemoveWishlist {
  String? id;
  String? token;
  String? slug;
  String? quantity;
  String? store;

  RemoveWishlist({
    this.id,
    this.token,
    this.slug,
    this.quantity,
    this.store,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'slug': slug,
      'quantity': quantity,
      'store':store,
    };
  }
}
