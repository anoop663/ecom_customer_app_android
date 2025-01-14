import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/modules/products/controllers/add_to_wishlist.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/shimmer_utils.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class BestItems extends StatelessWidget {
  BestItems({super.key});
  final HomeController homeController = Get.put(HomeController());
  final AddToWishlistController wishListController =
      Get.put(AddToWishlistController());

  @override
  Widget build(BuildContext context) {
    var bestItems = homeController.homeResponse.value;

    return Scaffold(
      appBar: CommonAppBar(
        showLogo: false,
        toolBarTitle: 'Best Items',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bestItems?.bestSeller != null &&
                bestItems!.bestSeller!.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: bestItems.bestSeller!.length,
                  itemBuilder: (context, index) {
                    final product = bestItems.bestSeller![index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.productdetails,
                          arguments: {'product-slug': product.slug},
                        );
                      },
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) {
                                      return ShimmerUtil().container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width: double.infinity,
                                      );
                                    },
                                    imageUrl: product.images!.first,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? 'No Name',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.textColor2,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                          // Add Favorite Icon
                          Obx(() {
                            final isFavorite = wishListController
                                    .favoriteStatus[product.slug] ??
                                false;
                            return Positioned(
                              top: 8.0,
                              right: 8.0,
                              child: GestureDetector(
                                onTap: () {
                                  // wishListController.toggleFavorite(
                                  //   product.slug!,
                                  // );
                                  wishListController.addAndRemovewishList(
                                      slug: product.slug, isBestItems: true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isFavorite
                                        ? Colors.transparent
                                        : Colors.transparent,
                                  ),
                                  child: Icon(
                                    product.wishlist!.value == 1
                                        ? Icons.favorite // Filled heart
                                        : Icons
                                            .favorite_border, // Outline heart
                                    color: product.wishlist!.value == 1
                                        ? AppColors.redColor
                                        : AppColors.textColor2,
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
              const Center(
                child: Text('No Products available'),
              ),
          ],
        ),
      ),
    );
  }
}
