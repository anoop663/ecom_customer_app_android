// models/user_model.dart
class AddToBagWishlist {
  String? id;
  String? token;
  String? slug;
  String? quantity;
  String? store;

  AddToBagWishlist({
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
