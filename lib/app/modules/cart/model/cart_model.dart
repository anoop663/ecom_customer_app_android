
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
