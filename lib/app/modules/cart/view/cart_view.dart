import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/cart/view/cart_item.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:ecommerce_app/app/widgets/support_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    cartController.viewCart();
    final currentTheme = Get.theme;
    return Scaffold(
      backgroundColor: AppColors.textColor1,
      appBar: CommonAppBar(
        toolBarTitle: 'CART',
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => cartController.loading.isTrue
                  ? const LoadingWidget()
                  : cartController.cartResponse.value == null
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
                                    ///cart items
                                    Container(
                                      color: AppColors.primary,
                                      child: Obx(
                                        () => ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: cartController.cartResponse
                                              .value!.products!.length,
                                          padding: const EdgeInsets.all(16),
                                          itemBuilder: (context, i) {
                                            return CartItem(
                                              product: cartController
                                                  .cartResponse
                                                  .value!
                                                  .products![i],
                                            );
                                          },
                                        ),
                                      ),
                                    ),

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
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    ///price summary
                                    Container(
                                        color: AppColors.primary,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(
                                          16.0,
                                        ),
                                        child: Obx(
                                          () => Column(
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
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              PriceSummaryItem(
                                                title: 'Grand Total',
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
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )),

                                    ///seperator with decoration
                                    CustomPaint(
                                      painter: PointedDecorationPainter(),
                                      size: Size(
                                          MediaQuery.of(context).size.width, 0),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

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
                                    const SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Obx(
                                      () => Text(
                                        '₹ ${cartController.cartResponse.value!.netTotal!}',
                                        style: const TextStyle(
                                          color: AppColors.viewAll,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: CurvedButton(
                                    onClick: () {
                                      //
                                    },
                                    text: 'PROCEED',
                                    textColor: Colors.white,
                                    fontweight: FontWeight.bold,
                                    buttonColor: AppColors.viewAll,
                                    borderRadius: 4,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: 151,
            width: 138,
            child: Image.asset(
              ImageStrings.emptyCart,
            ),
          ),
          const Text(
            'Nothing in the bag',
            style: TextStyle(
              color: AppColors.textColor2,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CurvedButton(
            textColor: AppColors.textColor1,
            buttonColor: AppColors.bottomSelectedColor,
            borderColor: AppColors.bottomSelectedColor,
            fontweight: FontWeight.w500,
            borderRadius: 4.0,
            onClick: () {
              Get.offAllNamed(Routes.bottombar);
            },
            width: MediaQuery.of(context).size.width * 0.8,
            height: 44,
            isSelected: true,
            text: 'CONTINUE SHOPPING',
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

class PointedDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.square;
    var path = Path();
    var division = 0.045;
    path.moveTo(-10, 0);
    for (var i = division; i <= 1; i += division) {
      path.lineTo(size.width * i, size.width * division);
      i = (i + division);
      path.lineTo(size.width * i, 0);
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PriceSummaryItem extends StatelessWidget {
  const PriceSummaryItem({
    super.key,
    required this.title,
    required this.subTitle,
    this.fontweight,
    this.fontsize,
  });
  final String title, subTitle;
  final FontWeight? fontweight;
  final double? fontsize;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: currentTheme.textTheme.bodyMedium!.copyWith(
            color: AppColors.removeButton,
            fontWeight: fontweight,
            fontSize: fontsize,
          ),
        ),
        Text(
          subTitle.toLowerCase().contains('free') ? subTitle : subTitle,
          style: currentTheme.textTheme.bodyMedium!.copyWith(
            fontWeight: fontweight,
            fontSize: fontsize,
            color: subTitle.toLowerCase().contains('free')
                ? AppColors.offerTextBg
                : AppColors.removeButton,
          ),
        ),
      ],
    );
  }
}
