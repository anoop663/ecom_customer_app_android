import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/products/controllers/add_to_wishlist.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';

import '../../../core/utils/shimmer_utils.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    // ignore: unused_local_variable
    final CartController cartController = Get.put(CartController());
    final AddToWishlistController wishListController =
        Get.put(AddToWishlistController());

    homeController.homeLoad();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(showLogo: true),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeController.homeResponse.value != null) {
          final homeResponse = homeController.homeResponse.value;

          return RefreshIndicator(
            onRefresh: () async {
              homeController.homeLoad();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (homeResponse?.banner1 != null &&
                      homeResponse!.banner1!.isNotEmpty)

                    //First Banner Carosal
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                      ),
                      items: homeResponse.banner1!.map((banner) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.brandproducts,
                                  arguments: {
                                    'by': 'brand',
                                    'value': 'marella',
                                  },
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) {
                                    return ShimmerUtil()
                                        .container(width: double.infinity
                                            // height:
                                            // MediaQuery.of(context)
                                            //     .size
                                            //     .height *
                                            //     0.28,
                                            // width:
                                            // MediaQuery.of(context)
                                            //     .size
                                            //     .width *
                                            //     0.44,
                                            );
                                  },
                                  imageUrl:
                                      '${ApiConfig.bannerImageUrl}${banner.image ?? ''}',
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                      ImageStrings.noImage,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),

                                // Image.network(
                                //   '${ApiConfig.bannerImageUrl}${banner.image ?? ''}',
                                //   fit: BoxFit.cover,
                                //   width: double.infinity,
                                // ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Brands section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Our Brands',
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (homeResponse?.featuredbrands != null &&
                            homeResponse!.featuredbrands!.isNotEmpty)

                          //Brand Slider
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.2,
                              autoPlay: true,
                              enlargeCenterPage: false,
                              viewportFraction: 0.34,
                            ),
                            items: homeResponse.featuredbrands!.map((brand) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.brandproducts,
                                        arguments: {
                                          'by': 'brand',
                                          'value': brand.slug,
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(7.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) {
                                            return ShimmerUtil().container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.28,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.44,
                                            );
                                          },
                                          imageUrl: brand.image!,
                                          // height: MediaQuery.of(context)
                                          //     .size
                                          //     .height *
                                          //     0.28,
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
                                  );
                                },
                              );
                            }).toList(),
                          ),

                        /// Suggested for you section
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Suggested for you',
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        //ProductCarousal(),
                        if (homeResponse?.suggestedProducts != null &&
                            homeResponse!.suggestedProducts!.isNotEmpty)
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height *
                                  0.40, // Adjust height as needed
                              autoPlay: true,
                              enlargeCenterPage: false,
                              viewportFraction: 0.455,
                            ),
                            items: homeResponse.suggestedProducts!
                                .map((sugproducts) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.productdetails,
                                        arguments: {
                                          'product-slug': sugproducts.slug,
                                        },
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            // Product Image

                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.28,
                                              margin: const EdgeInsets.all(7.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) {
                                                    return ShimmerUtil()
                                                        .container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.28,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                    );
                                                  },
                                                  imageUrl:
                                                      '${ApiConfig.productImageUrl}${sugproducts.image}',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.28,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      ImageStrings.noImage,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            // Wishlist Icon
                                            // Obx(() {
                                            //   final isFavorite =
                                            //       wishListController
                                            //                   .favoriteStatus[
                                            //               sugproducts.slug] ??
                                            //           false;
                                            //   return Positioned(
                                            //     top: 10.0,
                                            //     right: 10.0,
                                            //     child: GestureDetector(
                                            //       onTap: () {
                                            //         wishListController
                                            //             .toggleFavorite(
                                            //                 sugproducts.slug!);
                                            //       },
                                            //       child: Container(
                                            //         padding:
                                            //             const EdgeInsets.all(
                                            //                 6.0),
                                            //         decoration: BoxDecoration(
                                            //           shape: BoxShape.circle,
                                            //           color: isFavorite
                                            //               ? Colors.transparent
                                            //               : Colors.transparent,
                                            //         ),
                                            //         child: Icon(
                                            //           isFavorite
                                            //               ? Icons
                                            //                   .favorite // Filled heart
                                            //               : Icons
                                            //                   .favorite_border, // Outline heart
                                            //           color: isFavorite
                                            //               ? AppColors.redColor
                                            //               : AppColors.textColor2,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   );
                                            // }),
                                            /// new wishlist icon added

                                            Obx(() {
                                              return Positioned(
                                                top: 10.0,
                                                right: 10.0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    wishListController
                                                        .addAndRemovewishList(
                                                            slug: sugproducts
                                                                .slug);

                                                    // wishListController
                                                    //     .toggleFavorite(
                                                    //     sugproducts.slug!);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: sugproducts
                                                                  .wishlist
                                                                  ?.value !=
                                                              1
                                                          ? Colors.transparent
                                                          : Colors.transparent,
                                                    ),
                                                    child: Icon(
                                                      sugproducts.wishlist
                                                                  ?.value ==
                                                              1
                                                          ? Icons
                                                              .favorite // Filled heart
                                                          : Icons
                                                              .favorite_border, // Outline heart
                                                      color: sugproducts
                                                                  .wishlist
                                                                  ?.value ==
                                                              1
                                                          ? AppColors.redColor
                                                          : AppColors.textColor2,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                        // Product Details
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            sugproducts.name!,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        if (homeResponse?.banner2 != null &&
                            homeResponse!.banner2!.isNotEmpty)

                          //Second Banner Carosal
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.4,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1.0,
                            ),
                            items: homeResponse.banner2!.map((bannersecond) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.brandproducts,
                                        arguments: {
                                          'by': 'brand',
                                          'value': 'fural',
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0),
                                      child: Image.network(
                                        ApiConfig.bannerImageUrl +
                                            (bannersecond.image ?? ''),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),

                        /// Best Sellers section
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Best Sellers',
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (homeResponse?.bestSeller != null &&
                            homeResponse!.bestSeller!.isNotEmpty)
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.40,
                              autoPlay: true,
                              enlargeCenterPage: false,
                              viewportFraction: 0.455,
                            ),
                            items: homeResponse.bestSeller!.map((bestproducts) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.productdetails,
                                        arguments: {
                                          'product-slug': bestproducts.slug,
                                        },
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.28,
                                              margin: const EdgeInsets.all(7.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) {
                                                    return ShimmerUtil()
                                                        .container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.28,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                    );
                                                  },
                                                  imageUrl:
                                                      '${ApiConfig.productImageUrl}${bestproducts.image}',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.28,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      ImageStrings.noImage,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   top: 10,
                                            //   right: 10,
                                            //   child: Obx(() {
                                            //     final isFavorite =
                                            //         wishListController
                                            //                     .favoriteStatus[
                                            //                 bestproducts
                                            //                     .slug] ??
                                            //             false;
                                            //     return Positioned(
                                            //       top: 10.0,
                                            //       right: 10.0,
                                            //       child: GestureDetector(
                                            //         onTap: () {
                                            //           wishListController
                                            //               .toggleFavorite(
                                            //                   bestproducts
                                            //                       .slug!);
                                            //         },
                                            //         child: Container(
                                            //           padding:
                                            //               const EdgeInsets.all(
                                            //                   6.0),
                                            //           decoration: BoxDecoration(
                                            //             shape: BoxShape.circle,
                                            //             color: isFavorite
                                            //                 ? Colors.transparent
                                            //                 : Colors
                                            //                     .transparent,
                                            //           ),
                                            //           child: Icon(
                                            //             isFavorite
                                            //                 ? Icons
                                            //                     .favorite // Filled heart
                                            //                 : Icons
                                            //                     .favorite_border, // Outline heart
                                            //             color: isFavorite
                                            //                 ? AppColors.redColor
                                            //                 : AppColors.textColor2,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     );
                                            //   }),
                                            // ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 1.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                bestproducts.name ??
                                                    'Unknown Product',
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: AppColors.textColor2,
                                                ),
                                              ),
                                              Text(
                                                '₹ ${bestproducts.price}',
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
                                  );
                                },
                              );
                            }).toList(),
                          ),

                        /// Trending Categories

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trending Categories',
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        GridView.builder(
                          itemCount: homeResponse?.categories?.length ??
                              0, // Check for null
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 9.0,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            // Null-safe access to the category and its properties
                            final category = homeResponse?.categories?[index];
                            final imageUrl = category?.category?.image ??
                                ''; // Replace with a placeholder if needed
                            final categoryTitle =
                                category?.category?.name ?? 'Unknown Category';

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.brandproducts,
                                  arguments: {
                                    'by': 'category',
                                    'value': category?.category?.slug,
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                          onError: (error, stackTrace) {
                                            // ignore: avoid_print
                                            print(
                                                'Failed to load image: $error');
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    categoryTitle,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),

                        SizedBox(height: 20),
                        Text(
                          'Shop Exclusive Deals',
                          style: const TextStyle(
                            color: AppColors.textColor2,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 10),
                        if (homeResponse!.banner1 != null &&
                            homeResponse.banner1!.isNotEmpty)
                          //Last BannerCarosal
                          CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.3,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                            ),
                            items: homeResponse.banner3!.map((banner) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.brandproducts,
                                        arguments: {
                                          'by': 'brand',
                                          'value': 'maxco',
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0),
                                      child: Image.network(
                                        ApiConfig.bannerImageUrl +
                                            (banner.image ?? ''),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              'Failed to load home page data\n\nCheck your Internet connection',
              style: TextStyle(color: AppColors.redColor),
            ),
          );
        }
      }),
    );
  }
}
