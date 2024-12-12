import 'dart:convert';

// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

OrderListResponse orderListResponseFromJson(String str) =>
    OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) =>
    json.encode(data.toJson());

class OrderListResponse {
  final int? success;
  final String? message;
  final Result? result;
  final dynamic bank;

  OrderListResponse({
    this.success,
    this.message,
    this.result,
    this.bank,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        bank: json["bank"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": result?.toJson(),
        "bank": bank,
      };
}

class Result {
  final int? currentPage;
  final List<Order>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Result({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Order {
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
  final PaymentMode? paymentMode;
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
  final List<ItemsNew>? itemsNew;
  final Currency? currency;
  final List<dynamic>? walletUsed;
  final List<dynamic>? walletCancelled;
  final List<dynamic>? walletReturned;
  final List<ItemsNew>? items;

  Order({
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
    this.itemsNew,
    this.currency,
    this.walletUsed,
    this.walletCancelled,
    this.walletReturned,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
        paymentMode: json["payment_mode"] == null
            ? null
            : json["payment_mode"] is int
                ? null
                : PaymentMode.fromJson(json["payment_mode"]),
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
        itemsNew: json["items_new"] == null
            ? []
            : List<ItemsNew>.from(
                json["items_new"]!.map((x) => ItemsNew.fromJson(x))),
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        walletUsed: json["wallet_used"] == null
            ? []
            : List<dynamic>.from(json["wallet_used"]!.map((x) => x)),
        walletCancelled: json["wallet_cancelled"] == null
            ? []
            : List<dynamic>.from(json["wallet_cancelled"]!.map((x) => x)),
        walletReturned: json["wallet_returned"] == null
            ? []
            : List<dynamic>.from(json["wallet_returned"]!.map((x) => x)),
        items: json["items"] == null
            ? []
            : List<ItemsNew>.from(
                json["items"]!.map(
                  (x) => ItemsNew.fromJson(x),
                ),
              ),
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
        "payment_mode": paymentMode?.toJson(),
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
        "items_new": itemsNew == null
            ? []
            : List<dynamic>.from(itemsNew!.map((x) => x.toJson())),
        "currency": currency?.toJson(),
        "wallet_used": walletUsed == null
            ? []
            : List<dynamic>.from(walletUsed!.map((x) => x)),
        "wallet_cancelled": walletCancelled == null
            ? []
            : List<dynamic>.from(walletCancelled!.map((x) => x)),
        "wallet_returned": walletReturned == null
            ? []
            : List<dynamic>.from(walletReturned!.map((x) => x)),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Currency {
  final String? name;
  final String? code;
  final String? symbolLeft;
  final String? symbolRight;

  Currency({
    this.name,
    this.code,
    this.symbolLeft,
    this.symbolRight,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
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
  final String? itemCancelReason;
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
  final List<ThisOption>? thisOptions;

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
            : List<ThisOption>.from(
                json["this_options"]!.map((x) => ThisOption.fromJson(x))),
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
            : List<dynamic>.from(thisOptions!.map((x) => x.toJson())),
      };
}

class ThisOption {
  final int? optionId;
  final Name? name;
  final int? productId;
  final int? id;
  final Type? type;
  final ThisValues? thisValues;

  ThisOption({
    this.optionId,
    this.name,
    this.productId,
    this.id,
    this.type,
    this.thisValues,
  });

  factory ThisOption.fromJson(Map<String, dynamic> json) => ThisOption(
        optionId: json["option_id"],
        name: nameValues.map[json["name"]]!,
        productId: json["product_id"],
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        thisValues: json["this_values"] == null
            ? null
            : ThisValues.fromJson(json["this_values"]),
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "name": nameValues.reverse[name],
        "product_id": productId,
        "id": id,
        "type": typeValues.reverse[type],
        "this_values": thisValues?.toJson(),
      };
}

// ignore: constant_identifier_names
enum Name { COLOR, SIZE }

final nameValues = EnumValues({"Color": Name.COLOR, "Size": Name.SIZE});

class ThisValues {
  final int? optionValueId;
  final String? value;
  final String? text;
  final String? slug;
  final int? productOptionId;

  ThisValues({
    this.optionValueId,
    this.value,
    this.text,
    this.slug,
    this.productOptionId,
  });

  factory ThisValues.fromJson(Map<String, dynamic> json) => ThisValues(
        optionValueId: json["option_value_id"],
        value: json["value"],
        text: json["text"],
        slug: json["slug"],
        productOptionId: json["product_option_id"],
      );

  Map<String, dynamic> toJson() => {
        "option_value_id": optionValueId,
        "value": value,
        "text": text,
        "slug": slug,
        "product_option_id": productOptionId,
      };
}

// ignore: constant_identifier_names
enum Type { TEXT }

final typeValues = EnumValues({"text": Type.TEXT});

class ItemsNew {
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
  final String? nonTaxAmount;
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
  final String? slug;
  final int? status;
  final String? stock;
  final String? image;
  final int? possibleAction;
  final String? statusText;
  final dynamic refund;
  final Product? product;

  ItemsNew({
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
    this.nonTaxAmount,
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
    this.slug,
    this.status,
    this.stock,
    this.image,
    this.possibleAction,
    this.statusText,
    this.refund,
    this.product,
  });

  factory ItemsNew.fromJson(Map<String, dynamic> json) => ItemsNew(
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
        nonTaxAmount: json["nonTaxAmount"],
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
        slug: json["slug"],
        status: json["status"],
        stock: json["stock"],
        image: json["image"],
        possibleAction: json["possible_action"],
        statusText: json["status_text"],
        refund: json["refund"],
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
        "nonTaxAmount": nonTaxAmount,
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
        "slug": slug,
        "status": status,
        "stock": stock,
        "image": image,
        "possible_action": possibleAction,
        "status_text": statusText,
        "refund": refund,
        "product": product?.toJson(),
      };
}

class PaymentMode {
  final int? id;
  final String? mode;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentMode({
    this.id,
    this.mode,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
        id: json["id"],
        mode: json["mode"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mode": mode,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
