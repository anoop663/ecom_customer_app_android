import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) =>
    CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) =>
    json.encode(data.toJson());

class CheckoutResponse {
  final int? success;
  final String? message;
  final OrderId? orderId;

  CheckoutResponse({
    this.success,
    this.message,
    this.orderId,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutResponse(
        success: json["success"],
        message: json["message"],
        orderId: json["order_id"] == null
            ? null
            : OrderId.fromJson(json["order_id"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "order_id": orderId?.toJson(),
      };
}

class OrderId {
  final int? id;
  final String? invoiceNumber;
  final int? storeId;
  final String? storeName;
  final int? customerId;
  final int? billingAddressId;
  final String? billingAddressType;
  final String? billingName;
  final String? billingEmail;
  final String? billingPhone;
  final String? billingAddress;
  final String? billingCity;
  final String? billingAreaNumber;
  final String? billingCountry;
  final String? billingZipcode;
  final dynamic billingLatitude;
  final dynamic billingLongitude;
  final int? shippingAddressId;
  final String? shippingAddressType;
  final String? shippingName;
  final String? shippingEmail;
  final String? shippingPhone;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingAreaNumber;
  final String? shippingCountry;
  final String? shippingZipcode;
  final dynamic shippingLatitude;
  final dynamic shippingLongitude;
  final String? comments;
  final dynamic deliveryNotes;
  final int? cartId;
  final String? totalAmount;
  final dynamic couponId;
  final dynamic couponCode;
  final String? couponDiscount;
  final int? couponDiscountType;
  final String? discountAmount;
  final String? swanCredit;
  final String? walletAmount;
  final String? shippingCharge;
  final String? totalTaxAmount;
  final String? netTotalAmount;
  final int? paymentMode;
  final dynamic deliveryMode;
  final dynamic pickupStoreId;
  final int? languageId;
  final int? currencyId;
  final String? currencyValue;
  final String? ip;
  final String? userAgent;
  final int? orderStatusId;
  final String? orderStatus;
  final int? paymentStatus;
  final String? orderCancelReason;
  final dynamic orderCancelDescription;
  final int? giftWrap;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderWalletAmount;
  final String? orderTotalAmount;
  final String? orderNetTotalAmount;
  final String? orderShippingCharge;
  final List<Item>? items;
  final List<dynamic>? walletUsed;
  final List<dynamic>? walletCancelled;
  final List<dynamic>? walletReturned;

  OrderId({
    this.id,
    this.invoiceNumber,
    this.storeId,
    this.storeName,
    this.customerId,
    this.billingAddressId,
    this.billingAddressType,
    this.billingName,
    this.billingEmail,
    this.billingPhone,
    this.billingAddress,
    this.billingCity,
    this.billingAreaNumber,
    this.billingCountry,
    this.billingZipcode,
    this.billingLatitude,
    this.billingLongitude,
    this.shippingAddressId,
    this.shippingAddressType,
    this.shippingName,
    this.shippingEmail,
    this.shippingPhone,
    this.shippingAddress,
    this.shippingCity,
    this.shippingAreaNumber,
    this.shippingCountry,
    this.shippingZipcode,
    this.shippingLatitude,
    this.shippingLongitude,
    this.comments,
    this.deliveryNotes,
    this.cartId,
    this.totalAmount,
    this.couponId,
    this.couponCode,
    this.couponDiscount,
    this.couponDiscountType,
    this.discountAmount,
    this.swanCredit,
    this.walletAmount,
    this.shippingCharge,
    this.totalTaxAmount,
    this.netTotalAmount,
    this.paymentMode,
    this.deliveryMode,
    this.pickupStoreId,
    this.languageId,
    this.currencyId,
    this.currencyValue,
    this.ip,
    this.userAgent,
    this.orderStatusId,
    this.orderStatus,
    this.paymentStatus,
    this.orderCancelReason,
    this.orderCancelDescription,
    this.giftWrap,
    this.createdAt,
    this.updatedAt,
    this.orderWalletAmount,
    this.orderTotalAmount,
    this.orderNetTotalAmount,
    this.orderShippingCharge,
    this.items,
    this.walletUsed,
    this.walletCancelled,
    this.walletReturned,
  });

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        storeId: json["store_id"],
        storeName: json["store_name"],
        customerId: json["customer_id"],
        billingAddressId: json["billing_address_id"],
        billingAddressType: json["billing_address_type"],
        billingName: json["billing_name"],
        billingEmail: json["billing_email"],
        billingPhone: json["billing_phone"],
        billingAddress: json["billing_address"],
        billingCity: json["billing_city"],
        billingAreaNumber: json["billing_area_number"],
        billingCountry: json["billing_country"],
        billingZipcode: json["billing_zipcode"],
        billingLatitude: json["billing_latitude"],
        billingLongitude: json["billing_longitude"],
        shippingAddressId: json["shipping_address_id"],
        shippingAddressType: json["shipping_address_type"],
        shippingName: json["shipping_name"],
        shippingEmail: json["shipping_email"],
        shippingPhone: json["shipping_phone"],
        shippingAddress: json["shipping_address"],
        shippingCity: json["shipping_city"],
        shippingAreaNumber: json["shipping_area_number"],
        shippingCountry: json["shipping_country"],
        shippingZipcode: json["shipping_zipcode"],
        shippingLatitude: json["shipping_latitude"],
        shippingLongitude: json["shipping_longitude"],
        comments: json["comments"],
        deliveryNotes: json["delivery_notes"],
        cartId: json["cart_id"],
        totalAmount: json["total_amount"].toString(),
        couponId: json["coupon_id"],
        couponCode: json["coupon_code"],
        couponDiscount: json["coupon_discount"],
        couponDiscountType: json["coupon_discount_type"],
        discountAmount: json["discount_amount"],
        swanCredit: json["swan_credit"],
        walletAmount: json["wallet_amount"].toString(),
        shippingCharge: json["shipping_charge"],
        totalTaxAmount: json["total_tax_amount"],
        netTotalAmount: json["net_total_amount"].toString(),
        paymentMode: json["payment_mode"],
        deliveryMode: json["delivery_mode"],
        pickupStoreId: json["pickup_store_id"],
        languageId: json["language_id"],
        currencyId: json["currency_id"],
        currencyValue: json["currency_value"],
        ip: json["ip"],
        userAgent: json["user_agent"],
        orderStatusId: json["order_status_id"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        orderCancelReason: json["order_cancel_reason"],
        orderCancelDescription: json["order_cancel_description"],
        giftWrap: json["gift_wrap"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderWalletAmount: json["order_wallet_amount"],
        orderTotalAmount: json["order_total_amount"],
        orderNetTotalAmount: json["order_net_total_amount"],
        orderShippingCharge: json["order_shipping_charge"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        walletUsed: json["wallet_used"] == null
            ? []
            : List<dynamic>.from(json["wallet_used"]!.map((x) => x)),
        walletCancelled: json["wallet_cancelled"] == null
            ? []
            : List<dynamic>.from(json["wallet_cancelled"]!.map((x) => x)),
        walletReturned: json["wallet_returned"] == null
            ? []
            : List<dynamic>.from(json["wallet_returned"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "store_id": storeId,
        "store_name": storeName,
        "customer_id": customerId,
        "billing_address_id": billingAddressId,
        "billing_address_type": billingAddressType,
        "billing_name": billingName,
        "billing_email": billingEmail,
        "billing_phone": billingPhone,
        "billing_address": billingAddress,
        "billing_city": billingCity,
        "billing_area_number": billingAreaNumber,
        "billing_country": billingCountry,
        "billing_zipcode": billingZipcode,
        "billing_latitude": billingLatitude,
        "billing_longitude": billingLongitude,
        "shipping_address_id": shippingAddressId,
        "shipping_address_type": shippingAddressType,
        "shipping_name": shippingName,
        "shipping_email": shippingEmail,
        "shipping_phone": shippingPhone,
        "shipping_address": shippingAddress,
        "shipping_city": shippingCity,
        "shipping_area_number": shippingAreaNumber,
        "shipping_country": shippingCountry,
        "shipping_zipcode": shippingZipcode,
        "shipping_latitude": shippingLatitude,
        "shipping_longitude": shippingLongitude,
        "comments": comments,
        "delivery_notes": deliveryNotes,
        "cart_id": cartId,
        "total_amount": totalAmount,
        "coupon_id": couponId,
        "coupon_code": couponCode,
        "coupon_discount": couponDiscount,
        "coupon_discount_type": couponDiscountType,
        "discount_amount": discountAmount,
        "swan_credit": swanCredit,
        "wallet_amount": walletAmount,
        "shipping_charge": shippingCharge,
        "total_tax_amount": totalTaxAmount,
        "net_total_amount": netTotalAmount,
        "payment_mode": paymentMode,
        "delivery_mode": deliveryMode,
        "pickup_store_id": pickupStoreId,
        "language_id": languageId,
        "currency_id": currencyId,
        "currency_value": currencyValue,
        "ip": ip,
        "user_agent": userAgent,
        "order_status_id": orderStatusId,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "order_cancel_reason": orderCancelReason,
        "order_cancel_description": orderCancelDescription,
        "gift_wrap": giftWrap,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_wallet_amount": orderWalletAmount,
        "order_total_amount": orderTotalAmount,
        "order_net_total_amount": orderNetTotalAmount,
        "order_shipping_charge": orderShippingCharge,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "wallet_used": walletUsed == null
            ? []
            : List<dynamic>.from(walletUsed!.map((x) => x)),
        "wallet_cancelled": walletCancelled == null
            ? []
            : List<dynamic>.from(walletCancelled!.map((x) => x)),
        "wallet_returned": walletReturned == null
            ? []
            : List<dynamic>.from(walletReturned!.map((x) => x)),
      };
}

class Item {
  final int? id;
  final int? orderId;
  final String? sellerInvoiceReference;
  final String? itemCgst;
  final String? itemSgst;
  final String? itemIgst;
  final String? itemUtgst;
  final String? itemCess;
  final String? shippingCgst;
  final String? shippingSgst;
  final String? shippingIgst;
  final String? shippingUtgst;
  final String? shippingCess;
  final int? productId;
  final int? storeId;
  final dynamic paidToSellerReference;
  final String? sellerRefundAmount;
  final String? paidAmountToAdmin;
  final int? paidToAdmin;
  final dynamic paidToAdminDate;
  final dynamic paidToAdminReference;
  final String? productName;
  final String? quantity;
  final String? amount;
  final String? taxAmount;
  final dynamic couponAmount;
  final int? itemStatus;
  final String? shippingCharge;
  final int? returnPeriod;
  final String? refundPayable;
  final String? refundPayed;
  final dynamic refundBankId;
  final dynamic refundBankDetails;
  final dynamic itemCancelReason;
  final dynamic itemCancelDescription;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final String? utgst;
  final String? cess;
  final int? giftWrap;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  Item({
    this.id,
    this.orderId,
    this.sellerInvoiceReference,
    this.itemCgst,
    this.itemSgst,
    this.itemIgst,
    this.itemUtgst,
    this.itemCess,
    this.shippingCgst,
    this.shippingSgst,
    this.shippingIgst,
    this.shippingUtgst,
    this.shippingCess,
    this.productId,
    this.storeId,
    this.paidToSellerReference,
    this.sellerRefundAmount,
    this.paidAmountToAdmin,
    this.paidToAdmin,
    this.paidToAdminDate,
    this.paidToAdminReference,
    this.productName,
    this.quantity,
    this.amount,
    this.taxAmount,
    this.couponAmount,
    this.itemStatus,
    this.shippingCharge,
    this.returnPeriod,
    this.refundPayable,
    this.refundPayed,
    this.refundBankId,
    this.refundBankDetails,
    this.itemCancelReason,
    this.itemCancelDescription,
    this.cgst,
    this.sgst,
    this.igst,
    this.utgst,
    this.cess,
    this.giftWrap,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        sellerInvoiceReference: json["seller_invoice_reference"],
        itemCgst: json["item_cgst"],
        itemSgst: json["item_sgst"],
        itemIgst: json["item_igst"],
        itemUtgst: json["item_utgst"],
        itemCess: json["item_cess"],
        shippingCgst: json["shipping_cgst"],
        shippingSgst: json["shipping_sgst"],
        shippingIgst: json["shipping_igst"],
        shippingUtgst: json["shipping_utgst"],
        shippingCess: json["shipping_cess"],
        productId: json["product_id"],
        storeId: json["store_id"],
        paidToSellerReference: json["paid_to_seller_reference"],
        sellerRefundAmount: json["seller_refund_amount"],
        paidAmountToAdmin: json["paid_amount_to_admin"],
        paidToAdmin: json["paid_to_admin"],
        paidToAdminDate: json["paid_to_admin_date"],
        paidToAdminReference: json["paid_to_admin_reference"],
        productName: json["product_name"],
        quantity: json["quantity"],
        amount: json["amount"],
        taxAmount: json["tax_amount"],
        couponAmount: json["coupon_amount"],
        itemStatus: json["item_status"],
        shippingCharge: json["shipping_charge"],
        returnPeriod: json["return_period"],
        refundPayable: json["refund_payable"],
        refundPayed: json["refund_payed"],
        refundBankId: json["refund_bank_id"],
        refundBankDetails: json["refund_bank_details"],
        itemCancelReason: json["item_cancel_reason"],
        itemCancelDescription: json["item_cancel_description"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        igst: json["igst"],
        utgst: json["utgst"],
        cess: json["cess"],
        giftWrap: json["gift_wrap"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "seller_invoice_reference": sellerInvoiceReference,
        "item_cgst": itemCgst,
        "item_sgst": itemSgst,
        "item_igst": itemIgst,
        "item_utgst": itemUtgst,
        "item_cess": itemCess,
        "shipping_cgst": shippingCgst,
        "shipping_sgst": shippingSgst,
        "shipping_igst": shippingIgst,
        "shipping_utgst": shippingUtgst,
        "shipping_cess": shippingCess,
        "product_id": productId,
        "store_id": storeId,
        "paid_to_seller_reference": paidToSellerReference,
        "seller_refund_amount": sellerRefundAmount,
        "paid_amount_to_admin": paidAmountToAdmin,
        "paid_to_admin": paidToAdmin,
        "paid_to_admin_date": paidToAdminDate,
        "paid_to_admin_reference": paidToAdminReference,
        "product_name": productName,
        "quantity": quantity,
        "amount": amount,
        "tax_amount": taxAmount,
        "coupon_amount": couponAmount,
        "item_status": itemStatus,
        "shipping_charge": shippingCharge,
        "return_period": returnPeriod,
        "refund_payable": refundPayable,
        "refund_payed": refundPayed,
        "refund_bank_id": refundBankId,
        "refund_bank_details": refundBankDetails,
        "item_cancel_reason": itemCancelReason,
        "item_cancel_description": itemCancelDescription,
        "cgst": cgst,
        "sgst": sgst,
        "igst": igst,
        "utgst": utgst,
        "cess": cess,
        "gift_wrap": giftWrap,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}

class Product {
  final String? code;
  final int? userId;
  final int? status;
  final int? parentId;
  final int? isShowInList;
  final int? taxClassId;
  final String? slug;
  final int? isFeatured;
  final int? isPuliAssured;
  final String? weight;
  final String? sizeChart;
  final int? orderNumber;
  final String? rewardPoint;
  final String? purchaseReward;
  final String? metaTitle;
  final String? metaDescription;
  final dynamic metaKeywords;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final String? utgst;
  final String? cess;
  final int? isAlisonsAssured;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? isLatest;
  final int? isPopular;
  final int? isTrending;
  final int? isFlashsale;
  final int? variantProductId;
  final int? productVariant;
  final int? isGender;
  final List<dynamic>? thisOptions;

  Product({
    this.code,
    this.userId,
    this.status,
    this.parentId,
    this.isShowInList,
    this.taxClassId,
    this.slug,
    this.isFeatured,
    this.isPuliAssured,
    this.weight,
    this.sizeChart,
    this.orderNumber,
    this.rewardPoint,
    this.purchaseReward,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.cgst,
    this.sgst,
    this.igst,
    this.utgst,
    this.cess,
    this.isAlisonsAssured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isLatest,
    this.isPopular,
    this.isTrending,
    this.isFlashsale,
    this.variantProductId,
    this.productVariant,
    this.isGender,
    this.thisOptions,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        userId: json["user_id"],
        status: json["status"],
        parentId: json["parent_id"],
        isShowInList: json["is_show_in_list"],
        taxClassId: json["tax_class_id"],
        slug: json["slug"],
        isFeatured: json["is_featured"],
        isPuliAssured: json["is_puli_assured"],
        weight: json["weight"],
        sizeChart: json["size_chart"],
        orderNumber: json["order_number"],
        rewardPoint: json["reward_point"],
        purchaseReward: json["purchase_reward"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        igst: json["igst"],
        utgst: json["utgst"],
        cess: json["cess"],
        isAlisonsAssured: json["is_alisons_assured"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isLatest: json["is_latest"],
        isPopular: json["is_popular"],
        isTrending: json["is_trending"],
        isFlashsale: json["is_flashsale"],
        variantProductId: json["variant_product_id"],
        productVariant: json["product_variant"],
        isGender: json["is_gender"],
        thisOptions: json["this_options"] == null
            ? []
            : List<dynamic>.from(json["this_options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "user_id": userId,
        "status": status,
        "parent_id": parentId,
        "is_show_in_list": isShowInList,
        "tax_class_id": taxClassId,
        "slug": slug,
        "is_featured": isFeatured,
        "is_puli_assured": isPuliAssured,
        "weight": weight,
        "size_chart": sizeChart,
        "order_number": orderNumber,
        "reward_point": rewardPoint,
        "purchase_reward": purchaseReward,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "cgst": cgst,
        "sgst": sgst,
        "igst": igst,
        "utgst": utgst,
        "cess": cess,
        "is_alisons_assured": isAlisonsAssured,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "is_latest": isLatest,
        "is_popular": isPopular,
        "is_trending": isTrending,
        "is_flashsale": isFlashsale,
        "variant_product_id": variantProductId,
        "product_variant": productVariant,
        "is_gender": isGender,
        "this_options": thisOptions == null
            ? []
            : List<dynamic>.from(thisOptions!.map((x) => x)),
      };
}
