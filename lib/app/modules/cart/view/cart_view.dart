import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/cart/view/cart_item.dart';
import 'package:ecommerce_app/app/modules/cart/view/empty_cart.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:ecommerce_app/app/widgets/price_summery.dart';
import 'package:ecommerce_app/app/widgets/support_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    // Initial load of the cart data
    cartController.viewCart();
    final currentTheme = Get.theme;

    return Scaffold(
      backgroundColor: AppColors.textColor1,
      appBar: CommonAppBar(
        toolBarTitle: 'CART',
      ),
      body: Obx(() {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: cartController.loading.isTrue
                  ? const LoadingWidget()
                  : cartController.cartResponse.value == null ||
                          cartController.cartResponse.value!.products!.isEmpty
                      ? const EmptyCart()
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.82,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                controller: cartController.scrollController,
                                child: Column(
                                  children: [
                                    /// Cart items
                                    Container(
                                      color: AppColors.primary,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cartController.cartResponse
                                            .value!.products!.length,
                                        padding: const EdgeInsets.all(16),
                                        itemBuilder: (context, i) {
                                          return CartItem(
                                            product: cartController.cartResponse
                                                .value!.products![i],
                                          );
                                        },
                                      ),
                                    ),

                                    // Recommended products
                                    if (cartController.cartResponse.value!
                                        .recommendedProducts!.isNotEmpty)
                                      ColoredBox(
                                        color: AppColors.primary,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 320,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: cartController
                                                    .cartResponse
                                                    .value!
                                                    .recommendedProducts!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    const SizedBox(height: 20),

                                    /// Price summary
                                    Container(
                                        color: AppColors.primary,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Price Summary',
                                              style: currentTheme
                                                  .textTheme.bodyMedium!
                                                  .copyWith(
                                                color: AppColors.removeButton,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            PriceSummaryItem(
                                              title: 'Grand Total (Excl. VAT)',
                                              subTitle:
                                                  '₹ ${cartController.cartResponse.value!.grandTotal!}',
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                              height: 30,
                                              thickness: 1,
                                            ),
                                            PriceSummaryItem(
                                              title: 'VAT',
                                              subTitle:
                                                  '₹ ${cartController.cartResponse.value!.tax ?? ''}',
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                              height: 30,
                                              thickness: 1,
                                            ),
                                            PriceSummaryItem(
                                              title: 'Shipping Charges',
                                              subTitle: cartController
                                                          .cartResponse
                                                          .value!
                                                          .deliveryCharge ==
                                                      '0'
                                                  ? '₹ ${cartController.cartResponse.value!.deliveryCharge ?? '0'}'
                                                  : '₹ ${cartController.cartResponse.value!.deliveryCharge.toString()}',
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                              height: 30,
                                              thickness: 1,
                                            ),
                                            PriceSummaryItem(
                                              title: 'Net Total',
                                              subTitle:
                                                  '₹ ${cartController.cartResponse.value!.netTotal.toString()} ',
                                              fontweight: FontWeight.w500,
                                              fontsize: 16,
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        )),

                                    /// Separator with decoration
                                    CustomPaint(
                                      painter: PointedDecorationPainter(),
                                      size: Size(
                                          MediaQuery.of(context).size.width, 0),
                                    ),
                                    const SizedBox(height: 10),

                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SupportIcon(
                                          icon: IconStrings.cartExtra1,
                                          title: '100% SECURE\nPAYMENTS',
                                          backgroundColor:
                                              AppColors.transparent,
                                          fontColor: AppColors.cartExtraText,
                                          imageSize: 45,
                                        ),
                                        SupportIcon(
                                          icon: IconStrings.cartExtra2,
                                          title:
                                              'EASY RETURNS & QUICK\nREFUNDS',
                                          backgroundColor:
                                              AppColors.transparent,
                                          fontColor: AppColors.cartExtraText,
                                          imageSize: 45,
                                        ),
                                        SupportIcon(
                                          icon: IconStrings.cartExtra3,
                                          title: 'QUALITY\nASSURANCE',
                                          backgroundColor:
                                              AppColors.transparent,
                                          fontColor: AppColors.cartExtraText,
                                          imageSize: 45,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(
                                      '₹ ${cartController.cartResponse.value!.netTotal!}',
                                      style: const TextStyle(
                                        color: AppColors.viewAll,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: CurvedButton(
                                    onClick: () {
                                      // if (!Get.isRegistered<
                                      //     MyAddressListController>()) {
                                      //   Get.put(MyAddressListController());
                                      //   Get.find<MyAddressListController>()
                                      //       .getAddressFunction();
                                      // }else{
                                      //   Get.find<MyAddressListController>()
                                      //       .getAddressFunction();
                                      // }
                                      //
                                      // if (!Get.isRegistered<
                                      //     BaseController>()) {
                                      //   Get.put(BaseController());
                                      //   Get.find<BaseController>()
                                      //       .openAddressListBottomSheet();
                                      // }else{
                                      //   Get.find<BaseController>()
                                      //       .openAddressListBottomSheet();
                                      // }


                                      Get.toNamed(Routes.checkout);

                                    },
                                    text: 'PROCEED',
                                    textColor: Colors.white,
                                    fontweight: FontWeight.bold,
                                    buttonColor: AppColors.viewAll,
                                    borderRadius: 4,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
            ),
          ),
        );
      }),
    );
  }
}
