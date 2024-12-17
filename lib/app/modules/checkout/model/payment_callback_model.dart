class FinalCheckoutModel {
  String? id;
  String? token;
  String? status;
  String? invoiceNumber;
  // ignore: non_constant_identifier_names
  String? razorpay_payment_id;

  FinalCheckoutModel({
    this.id,
    this.token,
    this.invoiceNumber,
    this.status,
    // ignore: non_constant_identifier_names
    this.razorpay_payment_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'status': status,
      'invoiceNumber': invoiceNumber,
      'razorpay_payment_id': razorpay_payment_id,
    };
  }
}

