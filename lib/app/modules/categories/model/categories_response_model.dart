

class CategoriesResponseModel {
  final int success;
  final String message;
  final Products products;

  CategoriesResponseModel({
    required this.success,
    required this.message,
    required this.products,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) => CategoriesResponseModel(
        success: json["success"],
        message: json["message"],
        products: Products.fromJson(json["products"]),
      );
}

class Products {
  final Return returnData;
  final List<Category> categories;
  final List<Product> newProducts;

  Products({
    required this.returnData,
    required this.categories,
    required this.newProducts,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        returnData: Return.fromJson(json["return"]),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        newProducts: List<Product>.from(json["new_products"].map((x) => Product.fromJson(x))),
      );
}

class Return {
  final int currentPage;
  final List<Product> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  Return({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Return.fromJson(Map<String, dynamic> json) => Return(
        currentPage: json["current_page"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<PageLink>.from(json["links"].map((x) => PageLink.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class Product {
  final String slug;
  final int status;
  final String storeSlug;
  final String purchaseReward;
  final String rewardPoint;
  final String code;
  final String name;
  final String appDescription;
  final String stock;
  final String symbolLeft;
  final String symbolRight;
  final String oldPrice;
  final String price;
  final String discount;
  final String rating;
  final String image;
  final int wishlist;
  final int cart;
  final String store;
  final String manufacturer;

  Product({
    required this.slug,
    required this.status,
    required this.storeSlug,
    required this.purchaseReward,
    required this.rewardPoint,
    required this.code,
    required this.name,
    required this.appDescription,
    required this.stock,
    required this.symbolLeft,
    required this.symbolRight,
    required this.oldPrice,
    required this.price,
    required this.discount,
    required this.rating,
    required this.image,
    required this.wishlist,
    required this.cart,
    required this.store,
    required this.manufacturer,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        slug: json["slug"],
        status: json["status"],
        storeSlug: json["storeslug"],
        purchaseReward: json["purchase_reward"],
        rewardPoint: json["reward_point"],
        code: json["code"],
        name: json["name"],
        appDescription: json["app_description"],
        stock: json["stock"],
        symbolLeft: json["symbol_left"],
        symbolRight: json["symbol_right"],
        oldPrice: json["oldprice"],
        price: json["price"],
        discount: json["discount"],
        rating: json["rating"],
        image: json["image"],
        wishlist: json["wishlist"],
        cart: json["cart"],
        store: json["store"],
        manufacturer: json["manufacturer"],
      );
}

class Category {
  final String slug;
  final String image;
  final String name;
  final int parentId;

  Category({
    required this.slug,
    required this.image,
    required this.name,
    required this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        slug: json["slug"],
        image: json["image"],
        name: json["name"],
        parentId: json["parent_id"],
      );
}

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({
    required this.url,
    required this.label,
    required this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) => PageLink(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}