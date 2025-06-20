import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/brands/controllers/brand_product_controller.dart';
import 'package:ecommerce_app/app/modules/brands/controllers/filter_controller.dart';
import 'package:ecommerce_app/app/modules/brands/view/filter_sheet.dart';
import 'package:ecommerce_app/app/modules/brands/view/sort_sheet.dart';
import 'package:ecommerce_app/app/modules/products/controllers/add_to_wishlist.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/product_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/shimmer_utils.dart';

class BrandProducts extends StatefulWidget {
  const BrandProducts({super.key});

  @override
  State<BrandProducts> createState() => _BrandProductsState();
}

class _BrandProductsState extends State<BrandProducts> {
  final BrandProductController brandProductController =
      Get.put(BrandProductController());

  final currentTheme = Get.theme;

  // final FilterController controller = Get.put(FilterController());

  final AddToWishlistController wishListController =
      Get.put(AddToWishlistController());

  @override
  void initState() {
    // Fetch products based on 'by' and 'value'
    brandProductController.getBrandProducts1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        showLogo: false,
        toolBarTitle: 'Products',
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              var productsData =
                  brandProductController.brandproductResponse.value;

              if (brandProductController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productsData?.products != null &&
                      productsData!.products.returnData != null &&
                      productsData.products.returnData!.data.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount:
                            productsData.products.returnData!.data.length,
                        itemBuilder: (context, index) {
                          final product =
                              productsData.products.returnData!.data[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/product-details', arguments: {
                                'product-slug': product.slug,
                              });
                            },
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) {
                                            return ShimmerUtil().container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              width: double.infinity,
                                            );
                                          },
                                          imageUrl: ApiConfig.productImageUrl +
                                              product.image!,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          errorWidget: (context, url, error) {
                                            return Image.asset(
                                              ImageStrings.noImage,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name ?? '',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: AppColors.textColor2,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${product.price}',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.textColor2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Wishlist Icon
                                Obx(() {
                                  final isFavorite = wishListController
                                          .favoriteStatus[product.slug] ??
                                      false;
                                  return Positioned(
                                    top: 8.0,
                                    right: 8.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        // wishListController
                                        //     .toggleFavorite(product.slug!,);
                                        brandProductController
                                            .addAndRemovewishList(
                                          slug: product.slug!,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isFavorite
                                              ? Colors.transparent
                                              : Colors.transparent,
                                        ),
                                        child: GetBuilder<BrandProductController>(
                                          builder: (ctrl) {
                                            return Icon(
                                              // isFavorite
                                              product.wishlist == 1
                                                  ? Icons.favorite // Filled heart
                                                  : Icons
                                                      .favorite_border, // Outline heart
                                              color: productsData
                                                          .products
                                                          .returnData!
                                                          .data[index]
                                                          .wishlist ==
                                                      1
                                                  ? AppColors.redColor
                                                  : AppColors.textColor2,
                                            );
                                          }
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  else
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .7,
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          'No Products available',
                          style: TextStyle(color: AppColors.textColor2, fontSize: 15),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.primary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProductBottomIcon(
                    icon: IconStrings.sortIcon,
                    title: 'Sort',
                    onTap: () async {
                      if (!Get.isRegistered<FilterController>()) {
                        Get.put(FilterController());
                      }
                      await Get.bottomSheet(
                        SortSheet(
                          currentSelection:
                              brandProductController.selectedSortItem.value,
                          items: Get.put(FilterController()).sortItems,
                          onTap: (filter) {
                            // ignore: avoid_print
                            print(filter);

                            brandProductController.selectedSortItem.value =
                                filter;
                            brandProductController.getBrandProducts1(
                                sortOrder: 'DESC', sortby: 'price');
                            Get.back();
                          },
                        ),
                        persistent: true,
                        backgroundColor: currentTheme.primaryColor,
                      );
                    },
                  ),
                  SizedBox(
                    height: 40,
                    child: const VerticalDivider(
                      color: AppColors.textColor2,
                      indent: 1,
                      endIndent: 1,
                    ),
                  ),
                  ProductBottomIcon(
                    icon: IconStrings.filterIcon,
                    title: 'Filters',
                    onTap: () async {
                      if (!Get.isRegistered<FilterController>()) {
                        Get.put(FilterController());
                      }
                      await Get.bottomSheet(
                        FilterSheet(
                          onApply: (filter) {
                            if (filter == null) return;

                            List<Map<String, dynamic>> list = filter.entries
                                .map((entry) => {
                                      'type': entry.key,
                                      'values': entry.value,
                                    })
                                .toList();

                            final filterData = {"filters": list};

                            brandProductController.getBrandProducts1(
                                filter: json.encode(filterData));
                            Get.back();
                          },
                        ),
                        persistent: true,
                        backgroundColor: currentTheme.primaryColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
