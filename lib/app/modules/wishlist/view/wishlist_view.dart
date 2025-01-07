import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/wishlist/controller/add_to_bag_controller.dart';
import 'package:ecommerce_app/app/modules/wishlist/controller/remove_from_wishlist_controller.dart';
import 'package:ecommerce_app/app/modules/wishlist/controller/wislist_controller.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/empty_wishlist.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListView extends StatelessWidget {
  WishListView({super.key});

  final WishListController wishListController = Get.put(WishListController());
  final RemoveFromWishlistController removeFromWishlistController =
      RemoveFromWishlistController();
  final AddToBagFromWishlistController addtobagWishlistController =
      AddToBagFromWishlistController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        showLogo: false,
        showWishList: false,
        toolBarTitle: 'My Wishlist',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Obx(() {
              if (wishListController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                );
              }

              final wishlistItems = wishListController.wishlistResponse.value;

              if (wishlistItems?.products != null &&
                  wishlistItems!.products.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: wishlistItems.products.length,
                    itemBuilder: (context, index) {
                      final product = wishlistItems.products[index];

                      return GestureDetector(
                        onTap: () {
                          // Navigate to product details page with slug
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.29,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  // ignore: unnecessary_null_comparison
                                  child: product.image != null &&
                                          product.image.isNotEmpty
                                      ? Image.network(
                                          '${ApiConfig.productImageUrl}${product.image}',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/no_image.png',
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/no_image.png',
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Handle wishlist item removal
                                      // ignore: avoid_print
                                      print(product.slug);
                                      // ignore: avoid_print
                                      print(product.storeSlug);
                                      await removeFromWishlistController
                                          .removeFromWishlist(
                                              productSlug: product.slug,
                                              storeSlug: product.storeSlug);
                                      wishListController.showWishListFunction();
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '₹ ${product.price}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      addtobagWishlistController
                                          .movetoCartWishlist(product.slug);
                                      removeFromWishlistController
                                          .removeFromWishlist(
                                              productSlug: product.slug,storeSlug: product.storeSlug);
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        wishListController
                                            .showWishListFunction();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 228, 220, 220)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          IconStrings.cartIcon,
                                          height: 19,
                                          color: AppColors.backgroundOverlay,
                                        ),
                                        const SizedBox(width: 14),
                                        const Text(
                                          'ADD TO BAG',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return EmptyWishlist();
              }
            }),
          ],
        ),
      ),
    );
  }
}
