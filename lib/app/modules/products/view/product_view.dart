import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/products/controllers/add_to_cart.dart';
import 'package:ecommerce_app/app/modules/products/controllers/add_to_wishlist.dart';
import 'package:ecommerce_app/app/modules/products/controllers/product_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/loading_widget.dart';

// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  int _currentImageIndex = 0;
  final String productSlug = Get.arguments['product-slug'] ?? 'No-slug';
  ProductPage({super.key});
  AddToWishlistController wishlistController = AddToWishlistController();
  AddToCartController addToCartController = AddToCartController();
  final CartController cartcontroller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    controller.fetchProductDetails(productSlug: productSlug);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.productResponse.value?.product != null) {
          final product = controller.productResponse.value!.product!;
          //  final selectoption =
          //    controller.productResponse.value!.selectedOption!.first;
          //print(selectoption);
          return Column(
            children: [
              buildImageSlider(context, product.images!),
              const SizedBox(height: 8),
              buildIndicator(product.images!.length),
              buildProductDetailsSection(product),
              buildBottomButtons()
            ],
          );
        } else {
          return const Center(child: Text("Failed to load product details"));
        }
      }),
    );
  }

  Widget buildImageSlider(BuildContext context, List<String> images) {
    return Stack(
      children: [
        CarouselSlider(
          items: images.map((imageUrl) {
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImageStrings.noImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.5,
            viewportFraction: 1.0,
            autoPlay: false,
            onPageChanged: (index, reason) {
              _currentImageIndex = index;
            },
          ),
        ),
        Positioned(
          top: 40.0,
          // left: 16.0,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color.fromARGB(255, 142, 136, 136),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Positioned(
          top: 40.0,
          right: 16.0,
          child: Row(
            children: [
              // Wishlist Button
              InkWell(
                onTap: () async {
                  await Future.delayed(const Duration(milliseconds: 10));
                  await Get.toNamed(Routes.wishlist);
                },
                child: Image.asset(
                  IconStrings.likeOutlined,
                  color: Color.fromARGB(255, 142, 136, 136),
                  height: 25,
                  width: 35,
                ),
              ),
              const SizedBox(width: 8),

              // Cart Button
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.cart);
                },
                child: SizedBox(
                  height: 30,
                  width: 35,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          IconStrings.cartIcon,
                          color: Color.fromARGB(255, 142, 136, 136),
                          height: 25,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Obx(() => CircleAvatar(
                              radius: 8,
                              backgroundColor: AppColors.accessoriesColor5,
                              child: Text(
                                '${cartcontroller.cartResponse.value?.products?.length ?? 0}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textColor1,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator(int imageCount) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: _currentImageIndex,
        count: imageCount,
        effect: const ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: AppColors.textColor2,
          dotColor: Colors.grey,
        ),
      ),
    );
  }

  Widget buildProductDetailsSection(product) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor2,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "₹ ${product.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor2,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color.fromARGB(255, 231, 222, 222)),
            buildProductDescription(product.description),
          ],
        ),
      ),
    );
  }

  Widget buildProductDescription(String? description) {
    return description != null
        ? ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor2,
                ),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor2,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget buildBottomButtons() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 9,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          // Wishlist Button on the left
          Expanded(
            child: CurvedButton(
              onClick: () {
                wishlistController.wislistFunction(productSlug,);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconStrings.likeOutlined,
                    height: 19,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "WISHLIST",
                    style: Get.theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.textColor2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 2),
          // Add to Cart Button on the right
          Expanded(
              child: CurvedButton(
            onClick: num.parse(controller.productResponse.value!.product!
                        .stores!.first.stock!) !=
                    0
                ? () async {
                    controller.productResponse.value!.product!.cart == 0
                        ? addToCartController.addtoCartFunction(
                            from: 'productDetails', productSlug: productSlug)
                        : Get.toNamed(Routes.cart);
                  }
                : null,
            buttonColor: !addToCartController.isLoading.value
                ? AppColors.bottomSelectedColor
                : AppColors.searchBox,
            child: !addToCartController.isLoading.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        IconStrings.cartIcon,
                        height: 19,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 14),
                      Obx(
                        () => Text(
                          num.parse(controller.productResponse.value!.product!
                                      .stores!.first.stock!) !=
                                  0
                              ? controller.productResponse.value!.product!
                                          .cart ==
                                      0
                                  ? 'ADD TO BAG'
                                  : 'GO TO CART'
                              : 'OUT OF STOCK',
                          style: Get.theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  )
                : Center(child: LoadingWidget()),
          )),
        ],
      ),
    );
  }
}
