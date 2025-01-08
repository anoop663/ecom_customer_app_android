import 'dart:convert';

import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:get/get.dart';

class HomeAuth {
  final String? id;
  final String? token;
  HomeAuth({
    this.id,
    this.token,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
    };
  }
}

class DeliveryDetails {
  final int? returnPolicy;
  final int? deliveryPosible;
  final int? codAvailable;

  DeliveryDetails({
    this.returnPolicy,
    this.deliveryPosible,
    this.codAvailable,
  });

  factory DeliveryDetails.fromJson(Map<String, dynamic> json) =>
      DeliveryDetails(
        returnPolicy: json["return_policy"],
        deliveryPosible: json["delivery_posible"],
        codAvailable: json["cod_available"],
      );

  Map<String, dynamic> toJson() => {
        "return_policy": returnPolicy,
        "delivery_posible": deliveryPosible,
        "cod_available": codAvailable,
      };
}

class CartProduct {
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
  final dynamic productVariant;
  final int? isGender;
  final List<ThisOption>? thisOptions;

  CartProduct({
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

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
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

class Product {
  final int? the0;
  final int? id;
  final String? slug;
  final String? code;
  final String? name;
  final String? description;
  final String? appDescription;
  final int? storeId;
  final Rxn<String>? stock;
  final String? commission;
  final int? type;
  final String? storeslug;
  final String? seller;
  final String? manufacturer;
  final String? value;
  final String? symbolLeft;
  final String? symbolRight;
  final int? productId;
  final String? cgst;
  final String? sgst;
  final String? igst;
  final String? utgst;
  final String? cess;
  final String? quantity;
  final String? oldprice;
  final String? price;
  final String? singleprice;
  final String? discount;
  final String? rating;
  final String? image;
  final RxInt? wishlist;
  final int? deliveryCharge;
  final DeliveryDetails? deliveryDetails;
  final CartProduct? product;

  final String? sizeChart;
  final String? metaTitle;
  final String? metaDescription;
  final dynamic metaKeywords;
  final int? parentId;

  final String? store;

  final String? purchaseReward;
  final String? rewardPoint;

  final bool? isLiked;
  // ignore: prefer_typing_uninitialized_variables
  var cart;
  final int? reviewscount;
  final int? ratingcount;
  final String? sellerrating;
  final List<Options>? options;
  final List<AllOptions>? allOptions;
  final List<dynamic>? address;
  final List<String>? images;
  final List<String>? thumbnails;
  final List<StoreElement>? stores;
  final List<dynamic>? reviews;
  final List<dynamic>? specifications;
  final List<dynamic>? pOptions;
  final List<dynamic>? relatedOptions;
  final List<Product>? relatedProducts;

  Product({
    this.slug,
    this.code,
    this.sizeChart,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.parentId,
    this.name,
    this.description,
    this.appDescription,
    this.storeslug,
    this.store,
    this.stock,
    this.manufacturer,
    this.symbolLeft,
    this.symbolRight,
    this.purchaseReward,
    this.rewardPoint,
    this.oldprice,
    this.price,
    this.discount,
    this.rating,
    this.image,
    this.wishlist,
    this.isLiked,
    this.cart,
    this.reviewscount,
    this.ratingcount,
    this.sellerrating,
    this.options,
    this.address,
    this.images,
    this.thumbnails,
    this.stores,
    this.reviews,
    this.specifications,
    this.pOptions,
    this.relatedOptions,
    this.relatedProducts,
    this.id,
    this.value,
    this.productId,

    ///
    this.the0,
    this.storeId,
    this.commission,
    this.type,
    this.seller,
    this.cgst,
    this.sgst,
    this.igst,
    this.utgst,
    this.cess,
    this.quantity,
    this.singleprice,
    this.deliveryCharge,
    this.deliveryDetails,
    this.product,
    this.allOptions,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        slug: json["slug"],
        code: json["code"],
        sizeChart: json["size_chart"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        parentId: json["parent_id"],
        name: json["name"],
        description: json["description"],
        appDescription: json["app_description"],
        storeslug: json["storeslug"],
        store: json["store"],
        stock: Rxn(json["stock"]),
        manufacturer: json["manufacturer"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        purchaseReward: json["purchase_reward"],
        rewardPoint: json["reward_point"],
        oldprice: json["oldprice"],
        price: json["price"],
        discount: json["discount"],
        rating: json["rating"],
        wishlist: RxInt(json["wishlist"]),
        isLiked: json["wishlist"] == null
            ? false
            : json["wishlist"] == 1
                ? true
                : false,
        cart: json["cart"],
        reviewscount: json["reviewscount"],
        ratingcount: json["ratingcount"],
        sellerrating: json["sellerrating"],
        options: json["options"] == null
            ? []
            : List<Options>.from(
                json["options"]!.map((x) => Options.fromJson(x))),
        allOptions: json["all_options"] == null
            ? []
            : List<AllOptions>.from(
                json["all_options"]!.map((x) => AllOptions.fromJson(x))),

        address: json["address"] == null
            ? []
            : List<dynamic>.from(json["address"]!.map((x) => x)),
        images: json["images"] == null
            ? [
                ApiConfig.productImageUrl + json["image"],
              ]
            : List<String>.from(
                json["images"]!.map(
                  (x) => ApiConfig.productImageUrl + x['image'],
                ),
              ),
        thumbnails: json["images"] == null
            ? [
                ApiConfig.productThumbImageUrl + json["image"],
              ]
            : List<String>.from(
                json["images"]!.map(
                  (x) => ApiConfig.productThumbImageUrl + x['image'],
                ),
              ),
        stores: json["stores"] == null
            ? []
            : List<StoreElement>.from(
                json["stores"]!.map((x) => StoreElement.fromJson(x))),
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        specifications: json["specifications"] == null
            ? []
            : List<dynamic>.from(json["specifications"]!.map((x) => x)),
        pOptions: json["p_options"] == null
            ? []
            : List<dynamic>.from(json["p_options"]!.map((x) => x)),
        relatedOptions: json["related_options"] == null
            ? []
            : List<dynamic>.from(json["related_options"]!.map((x) => x)),
        relatedProducts: json["related_products"] == null
            ? []
            : List<Product>.from(
                json["related_products"]!.map((x) => Product.fromJson(x))),
        id: json["id"],
        value: json["value"],
        productId: json["product_id"],

        ///
        the0: json["0"],

        storeId: json["store_id"],

        commission: json["commission"],
        type: json["type"],

        seller: json["seller"],

        cgst: json["cgst"],
        sgst: json["sgst"],
        igst: json["igst"],
        utgst: json["utgst"],
        cess: json["cess"],
        quantity: json["quantity"].toString(),

        singleprice: json["singleprice"],

        image: json["image"],

        deliveryCharge: json["delivery_charge"],
        deliveryDetails: json["delivery_details"] == null
            ? null
            : DeliveryDetails.fromJson(json["delivery_details"]),
        product: json["product"] == null
            ? null
            : CartProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "code": code,
        "size_chart": sizeChart,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "parent_id": parentId,
        "name": name,
        "description": description,
        "app_description": appDescription,
        "storeslug": storeslug,
        "store": store,
        "stock": stock!.value,
        "manufacturer": manufacturer,
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
        "purchase_reward": purchaseReward,
        "reward_point": rewardPoint,
        "oldprice": oldprice,
        "price": price,
        "discount": discount,
        "rating": rating,
        "image": image,
        "wishlist": wishlist,
        "cart": cart,
        "reviewscount": reviewscount,
        "ratingcount": ratingcount,
        "sellerrating": sellerrating,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "address":
            address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
        "images": images == null
            ? []
            : List<dynamic>.from(
                images!.map((x) => ApiConfig.productImageUrl + x)),
        "stores": stores == null
            ? []
            : List<dynamic>.from(stores!.map((x) => x.toJson())),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "specifications": specifications == null
            ? []
            : List<dynamic>.from(specifications!.map((x) => x)),
        "p_options":
            pOptions == null ? [] : List<dynamic>.from(pOptions!.map((x) => x)),
        "related_options": relatedOptions == null
            ? []
            : List<dynamic>.from(relatedOptions!.map((x) => x)),
        "related_products": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
        "id": id,
        "value": value,
        "product_id": productId,
      };
}

class StoreElement {
  final int? id;
  final int? productId;
  final int? storeId;
  final String? defaultPrice;
  final String? stock;
  final String? minQuantity;
  final String? maxQuantity;
  final String? currentPrice;
  final String? cost;
  final int? returnPeriod;
  final int? status;
  final String? commission;
  final int? stockAlertQuantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? price;
  final String? rating;
  final StoreStore? store;

  StoreElement({
    this.id,
    this.productId,
    this.storeId,
    this.defaultPrice,
    this.stock,
    this.minQuantity,
    this.maxQuantity,
    this.currentPrice,
    this.cost,
    this.returnPeriod,
    this.status,
    this.commission,
    this.stockAlertQuantity,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.rating,
    this.store,
  });

  factory StoreElement.fromJson(Map<String, dynamic> json) => StoreElement(
        id: json["id"],
        productId: json["product_id"],
        storeId: json["store_id"],
        defaultPrice: json["default_price"],
        stock: json["stock"],
        minQuantity: json["min_quantity"],
        maxQuantity: json["max_quantity"],
        currentPrice: json["current_price"],
        cost: json["cost"],
        returnPeriod: json["return_period"],
        status: json["status"],
        commission: json["commission"],
        stockAlertQuantity: json["stock_alert_quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        price: json["price"],
        rating: json["rating"],
        store:
            json["store"] == null ? null : StoreStore.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "store_id": storeId,
        "default_price": defaultPrice,
        "stock": stock,
        "min_quantity": minQuantity,
        "max_quantity": maxQuantity,
        "current_price": currentPrice,
        "cost": cost,
        "return_period": returnPeriod,
        "status": status,
        "commission": commission,
        "stock_alert_quantity": stockAlertQuantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "price": price,
        "rating": rating,
        "store": store?.toJson(),
      };
}

class StoreStore {
  final int? id;
  final String? name;
  final String? address;
  final String? slug;
  final String? latitude;
  final String? longtitude;
  final String? image;
  final String? phoneNumber;

  StoreStore({
    this.id,
    this.name,
    this.address,
    this.slug,
    this.latitude,
    this.longtitude,
    this.image,
    this.phoneNumber,
  });

  factory StoreStore.fromJson(Map<String, dynamic> json) => StoreStore(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        slug: json["slug"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        image: json["image"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "slug": slug,
        "latitude": latitude,
        "longtitude": longtitude,
        "image": image,
        "phone_number": phoneNumber,
      };
}

class Options {
  final int? id;
  final int? productId;
  final int? parentProductId;
  final int? optionId;
  final int? isVarient;
  final int? order;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Value>? values;

  Options({
    this.id,
    this.productId,
    this.parentProductId,
    this.optionId,
    this.isVarient,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.values,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        id: json["id"],
        productId: json["product_id"],
        parentProductId: json["parent_product_id"],
        optionId: json["option_id"],
        isVarient: json["is_varient"],
        order: json["order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "parent_product_id": parentProductId,
        "option_id": optionId,
        "is_varient": isVarient,
        "order": order,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class Value {
  final int? id;
  final int? productOptionId;
  final int? productId;
  final int? parentProductId;
  final int? optionValueId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Value({
    this.id,
    this.productOptionId,
    this.productId,
    this.parentProductId,
    this.optionValueId,
    this.createdAt,
    this.updatedAt,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        productOptionId: json["product_option_id"],
        productId: json["product_id"],
        parentProductId: json["parent_product_id"],
        optionValueId: json["option_value_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_option_id": productOptionId,
        "product_id": productId,
        "parent_product_id": parentProductId,
        "option_value_id": optionValueId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class AllOptions {
  final int? optionId;
  final String? name;
  final int? productId;
  final int? parentProductId;
  final int? id;
  final String? type;
  final List<AllOptionValue>? values;

  AllOptions({
    this.optionId,
    this.name,
    this.productId,
    this.parentProductId,
    this.id,
    this.type,
    this.values,
  });

  factory AllOptions.fromJson(Map<String, dynamic> json) {
    var a = List<AllOptionValue>.from(
        json["values"]!.map((x) => AllOptionValue.fromJson(x)));
    a.sort(
      (a, b) => a.srtOrder!.compareTo(b.srtOrder!),
    );
    var options = AllOptions(
      optionId: json["option_id"],
      name: json["name"],
      productId: json["product_id"],
      parentProductId: json["parent_product_id"],
      id: json["id"],
      type: json["type"],
      values: json["values"] == null ? [] : a.toList(),
    );

    // ignore: avoid_print
    print("sorted order :");
    for (var element in options.values!) {
      // ignore: avoid_print
      print(element.srtOrder);
    }
    return options;
  }

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "name": name,
        "product_id": productId,
        "parent_product_id": parentProductId,
        "id": id,
        "type": type,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class AllOptionValue {
  final int? optionValueId;
  final String? value;
  final String? text;
  final String? stock;
  final int? productOptionId;
  final int? srtOrder;

  AllOptionValue({
    this.optionValueId,
    this.value,
    this.text,
    this.stock,
    this.productOptionId,
    this.srtOrder,
  });

  factory AllOptionValue.fromJson(Map<String, dynamic> json) => AllOptionValue(
        optionValueId: json["option_value_id"],
        value: json["value"],
        text: json["text"],
        stock: json["stock"] != null ? json["stock"].toString() : '0.00',
        productOptionId: json["product_option_id"],
        srtOrder: json['srt_order'],
      );

  Map<String, dynamic> toJson() => {
        "option_value_id": optionValueId,
        "value": value,
        "text": text,
        "stock": stock,
        "product_option_id": productOptionId,
        "srt_order": srtOrder,
      };
}

class ThisOption {
  final int? optionId;
  final String? name;
  final int? productId;
  final int? id;
  final String? type;
  final ThisValues? thisValues;

  ThisOption({
    this.optionId,
    this.name,
    this.productId,
    this.id,
    this.type,
    this.thisValues,
  });

  factory ThisOption.fromRawJson(String str) =>
      ThisOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThisOption.fromJson(Map<String, dynamic> json) => ThisOption(
        optionId: json["option_id"],
        name: json["name"],
        productId: json["product_id"],
        id: json["id"],
        type: json["type"],
        thisValues: json["this_values"] == null
            ? null
            : ThisValues.fromJson(json["this_values"]),
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "name": name,
        "product_id": productId,
        "id": id,
        "type": type,
        "this_values": thisValues?.toJson(),
      };
}

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

  factory ThisValues.fromRawJson(String str) =>
      ThisValues.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
