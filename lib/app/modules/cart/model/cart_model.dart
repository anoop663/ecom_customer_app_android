
class CartModel {
  String? id;
  String? token;
  String? billingaddressId;
  String? shippingaddressId;
  String? forwhat;

  CartModel({
    this.id,
    this.token,
    this.billingaddressId,
    this.shippingaddressId,
    this.forwhat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'billing_address_id': billingaddressId,
      'shipping_address_id': shippingaddressId,
      'for': forwhat,
    };
  }
}

class HomeAuth4 {
  final String? id;
  final String? token;
  final String? slug;
  final String? quantity;
  final String? store;
  HomeAuth4( {
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
      'quantity':quantity,
      'slug':slug,
      'store':store,
    };
  }
}
