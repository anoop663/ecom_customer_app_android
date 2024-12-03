class CheckoutModel {
  String? id;
  String? token;
  String? billingaddressId;
  String? shippingaddressId;
  String? paymentMode;

  CheckoutModel({
    this.id,
    this.token,
    this.billingaddressId,
    this.shippingaddressId,
    this.paymentMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'billing_address_id': billingaddressId,
      'shipping_address_id': shippingaddressId,
      'payment_mode': paymentMode,
    };
  }
}

