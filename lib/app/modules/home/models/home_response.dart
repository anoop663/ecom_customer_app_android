import 'dart:convert';

import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:soulstyle/app/modules/home/models/home_product_model.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  final int? success;
  final String? message;
  final List<BannerModel>? banner1;
  final List<BannerModel>? banner2;
  final List<BannerModel>? banner3;
  final List<BannerModel>? banner4;
  final List<BannerModel>? banner5;
  final List<dynamic>? recentviews;
  final List<Product>? ourProducts;
  final List<Product>? suggestedProducts;
  final List<Product>? bestSeller;
  final List<Product>? flashSail;
  final List<Product>? newarrivals;
  final List<Ory>? categories;
  final List<Ory>? topAccessories;
  final List<Brand>? featuredbrands;
  final int? cartcount;
  final dynamic wishlistcount;
  final Currency? currency;
  final int? notificationCount;

  HomeResponse({
    this.success,
    this.message,
    this.banner1,
    this.banner2,
    this.banner3,
    this.banner4,
    this.banner5,
    this.recentviews,
    this.ourProducts,
    this.suggestedProducts,
    this.bestSeller,
    this.flashSail,
    this.newarrivals,
    this.categories,
    this.topAccessories,
    this.featuredbrands,
    this.cartcount,
    this.wishlistcount,
    this.currency,
    this.notificationCount,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        success: json["success"],
        message: json["message"],
        banner1: json["banner1"] == null
            ? []
            : List<BannerModel>.from(
                json["banner1"]!.map((x) => BannerModel.fromJson(x))),
        banner2: json["banner2"] == null
            ? []
            : List<BannerModel>.from(
                json["banner2"]!.map((x) => BannerModel.fromJson(x))),
        banner3: json["banner3"] == null
            ? []
            : List<BannerModel>.from(
                json["banner3"]!.map((x) => BannerModel.fromJson(x))),
        banner4: json["banner4"] == null
            ? []
            : List<BannerModel>.from(
                json["banner4"]!.map((x) => BannerModel.fromJson(x))),
        banner5: json["banner5"] == null
            ? []
            : List<BannerModel>.from(
                json["banner5"]!.map((x) => BannerModel.fromJson(x))),
        recentviews: json["recentviews"] == null
            ? []
            : List<dynamic>.from(json["recentviews"]!.map((x) => x)),
        ourProducts: json["our_products"] == null
            ? []
            : List<Product>.from(
                json["our_products"]!.map((x) => Product.fromJson(x))),
        suggestedProducts: json["suggested_products"] == null
            ? []
            : List<Product>.from(
                json["suggested_products"]!.map((x) => Product.fromJson(x))),
        bestSeller: json["best_seller"] == null
            ? []
            : List<Product>.from(
                json["best_seller"]!.map((x) => Product.fromJson(x))),
        flashSail: json["flash_sail"] == null
            ? []
            : List<Product>.from(
                json["flash_sail"]!.map((x) => Product.fromJson(x))),
        newarrivals: json["newarrivals"] == null
            ? []
            : List<Product>.from(
                json["newarrivals"]!.map((x) => Product.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Ory>.from(json["categories"]!.map((x) => Ory.fromJson(x))),
        topAccessories: json["top_accessories"] == null
            ? []
            : List<Ory>.from(
                json["top_accessories"]!.map((x) => Ory.fromJson(x))),
        featuredbrands: json["featuredbrands"] == null
            ? []
            : List<Brand>.from(
                json["featuredbrands"]!.map((x) => Brand.fromJson(x))),
        cartcount: json["cartcount"],
        wishlistcount: json["wishlistcount"],
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        notificationCount: json["notification_count"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "banner1": banner1 == null
            ? []
            : List<dynamic>.from(banner1!.map((x) => x.toJson())),
        "banner2": banner2 == null
            ? []
            : List<dynamic>.from(banner2!.map((x) => x.toJson())),
        "banner3": banner3 == null
            ? []
            : List<dynamic>.from(banner3!.map((x) => x.toJson())),
        "banner4": banner4 == null
            ? []
            : List<dynamic>.from(banner4!.map((x) => x.toJson())),
        "banner5": banner5 == null
            ? []
            : List<dynamic>.from(banner5!.map((x) => x.toJson())),
        "recentviews": recentviews == null
            ? []
            : List<dynamic>.from(recentviews!.map((x) => x)),
        "our_products": ourProducts == null
            ? []
            : List<dynamic>.from(ourProducts!.map((x) => x.toJson())),
        "suggested_products": suggestedProducts == null
            ? []
            : List<dynamic>.from(suggestedProducts!.map((x) => x.toJson())),
        "best_seller": bestSeller == null
            ? []
            : List<dynamic>.from(bestSeller!.map((x) => x.toJson())),
        "flash_sail": flashSail == null
            ? []
            : List<dynamic>.from(flashSail!.map((x) => x.toJson())),
        "newarrivals": newarrivals == null
            ? []
            : List<dynamic>.from(newarrivals!.map((x) => x.toJson())),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "top_accessories": topAccessories == null
            ? []
            : List<dynamic>.from(topAccessories!.map((x) => x.toJson())),
        "featuredbrands": featuredbrands == null
            ? []
            : List<dynamic>.from(featuredbrands!.map((x) => x.toJson())),
        "cartcount": cartcount,
        "wishlistcount": wishlistcount,
        "currency": currency?.toJson(),
        "notification_count": notificationCount,
      };
}

class BannerModel {
  final int? id;
  final int? linkType;
  final String? linkValue;
  final String? image;
  final String? title;
  final String? subTitle;
  final dynamic logo;

  BannerModel({
    this.id,
    this.linkType,
    this.linkValue,
    this.image,
    this.title,
    this.subTitle,
    this.logo,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        linkType: json["link_type"],
        linkValue: json["link_value"],
        image: json["image"],
        title: json["title"],
        subTitle: json["sub_title"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link_type": linkType,
        "link_value": linkValue,
        "image": image,
        "title": title,
        "sub_title": subTitle,
        "logo": logo,
      };
}


class Ory {
  final HomeCategory? category;

  Ory({
    this.category,
  });

  factory Ory.fromJson(Map<String, dynamic> json) => Ory(
        category: json["category"] == null
            ? null
            : HomeCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
      };
}

class Brand {
  final int? id;
  final String? slug;
  final String? image;
  final String? brandLogo;
  final String? name;
  final String? description;

  Brand({
    this.id,
    this.slug,
    this.image,
    this.brandLogo,
    this.name,
    this.description,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        slug: json["slug"],
        image: ApiConfig.brandImageUrl + json["image"],
        brandLogo: json["brand_logo"] != null
            ? ApiConfig.brandImageUrl + json["brand_logo"]
            : null,
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "image": image,
        "brand_logo": brandLogo,
        "name": name,
        "description": description,
      };
}

class HomeCategory {
  final int? id;
  final String? slug;
  final String? image;
  final String? brandLogo;
  final String? name;
  final String? description;

  HomeCategory({
    this.id,
    this.slug,
    this.image,
    this.brandLogo,
    this.name,
    this.description,
  });

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
        id: json["id"],
        slug: json["slug"],
        image: ApiConfig.categoryImageUrl + json["image"],
        brandLogo: json["brand_logo"] != null
            ? ApiConfig.brandImageUrl + json["brand_logo"]
            : null,
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "image": image,
        "brand_logo": brandLogo,
        "name": name,
        "description": description,
      };
}

class Currency {
  final String? name;
  final String? code;
  final String? symbolLeft;
  final String? symbolRight;
  final String? value;
  final int? status;

  Currency({
    this.name,
    this.code,
    this.symbolLeft,
    this.symbolRight,
    this.value,
    this.status,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        value: json["value"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "symbol_left": symbolLeft,
        "symbol_right": symbolRight,
        "value": value,
        "status": status,
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
