import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/modules/cart/controller/cart_controller.dart';
import 'package:soulstyle/app/modules/home/models/home_product_model.dart';
import 'package:soulstyle/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/values/strings.dart';
import '../../products/controllers/add_to_cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    final AddToCartController addToCartController =
        Get.put(AddToCartController());

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CurvedButton(
        height: MediaQuery.of(context).size.height * 0.25 +
            (20 * product.product!.thisOptions!.length.toDouble()),
        borderColor: AppColors.cartItemBorder,
        borderRadius: 4,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15 +
                    (20 * product.product!.thisOptions!.length.toDouble()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.16 +
                          (20 *
                              product.product!.thisOptions!.length.toDouble()),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/no_image.png',
                          image: '${ApiConfig.productImageUrl}${product.image}',
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/no_image.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Product details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name!,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.cartProductTitle,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: product.product!.thisOptions!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemBuilder: (context, index) {
                              return Text(
                                '${product.product!.thisOptions![index].name!} : ${product.product?.thisOptions?[index].thisValues?.text ?? ''}',
                                style: const TextStyle(
                                  color: AppColors.viewAll,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          ),
                          Obx(
                            () => Row(
                              children: [
                                const Text(
                                  'Qty:',
                                  style: TextStyle(
                                    color: AppColors.viewAll,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CurvedButton(
                                  onClick: () {
                                    addToCartController.addtoCartFunction(
                                        productSlug: product.slug!,
                                        quantity:
                                            (int.parse(product.quantity!) - 1)
                                                .toString());
                                  },
                                  buttonColor: AppColors.sizeDropDownButton,
                                  borderColor: AppColors.sizeDropDownButton,
                                  borderRadius: 4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height: 22,
                                  text: '-',
                                  textColor: AppColors.viewAll,
                                ),
                                addToCartController.isItemSlug.value ==
                                        product.slug
                                    ? LottieBuilder.asset(
                                        AnimationStrings.loadingAnimation,
                                        height: 50,
                                        width: 50,
                                      )
                                    : Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            product.quantity!,
                                            style: const TextStyle(
                                              color: AppColors.viewAll,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                CurvedButton(
                                  onClick: () {
                                    addToCartController.addtoCartFunction(
                                        productSlug: product.slug!,
                                        quantity:
                                            (int.parse(product.quantity!) + 1)
                                                .toString());
                                  },
                                  buttonColor: AppColors.sizeDropDownButton,
                                  borderColor: AppColors.sizeDropDownButton,
                                  borderRadius: 4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                  height: 22,
                                  text: '+',
                                  textColor: AppColors.viewAll,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '₹ ${product.price!}',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.textColor2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              if (product.oldprice != product.price)
                                Text(
                                  '₹ ${product.oldprice!}',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => CurvedButton(
                        isLoading: controller.isRemovingItemSlug.value ==
                            product.slug.toString(),
                        onClick: () async {
                          if (!controller.isRemoving.value) {
                            await controller.removefromCartFunction(
                                product.slug.toString());
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: MediaQuery.of(context).size.height * 0.05,
                        text: "Remove",
                        borderColor: AppColors.cartButtonBorder,
                        borderRadius: 4,
                        textColor: AppColors.removeButton,
                        fontSize: 16,
                        fontweight: FontWeight.w500,
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                  Obx(() => CurvedButton(
                        isLoading: controller.isMovingToWishlistSlug.value ==
                            product.slug.toString(),
                        onClick: () async {
                          if (!controller.isMovingToWishlist.value) {
                            await controller.movetoWishListFunction(
                                product.slug.toString());
                          }
                        },
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        text: "Move to Wishlist",
                        borderColor: AppColors.cartButtonBorder,
                        borderRadius: 4,
                        textColor: AppColors.removeButton,
                        fontSize: 16,
                        fontweight: FontWeight.w500,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
