import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/checkout/controller/chekout_controller.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/support_icon.dart';
import '../widgets/address_expantion_tile.dart';
import '../widgets/item_expanded_tile.dart';
import '../widgets/order_information.dart';
import '../widgets/payment_tile.dart';

class CheckoutScreenView extends GetView<CheckoutScreenController> {
  const CheckoutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // final CheckoutScreenController controller =
    //     Get.put(CheckoutScreenController());

    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: AppColors.white60.withOpacity(0.95),
      appBar: CommonAppBar(
        toolBarTitle:
            'Payment: ₹ ${cartController.cartResponse.value?.netTotal ?? '0'}',
        showCart: false,
        showSearch: false,
        showWishList: false,
      ),
      body: Obx(
        () => controller.initialLoading.isTrue
            ? const Center(child: LoadingWidget())
            : cartController.cartResponse.value == null
                ? Center(
                    child: Text(
                      'Check Cart response',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Obx(
                                      () => AddressExpantionTile(
                                          address:
                                              controller.selectedAddress.value),
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(() => ItemsExpandTile(
                                          items: cartController.cartResponse
                                                  .value?.products ??
                                              [],
                                        )),
                                    const SizedBox(height: 20),
                                    ColoredBox(
                                      color: AppColors.primary,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Payment Methods',
                                                  style: Get.theme.textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                    color: AppColors.textColor2,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Obx(() =>
                                                CheckboxExpansionTile(
                                                  selectedMode: controller.paymentMode
                                                      .value,
                                                  onChanged: (value) {
                                                    controller.paymentMode
                                                        .value = value;
                                                  },
                                                  modes: controller
                                                      .cartResponse1
                                                      .value
                                                      ?.paymentModes,
                                                )),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Text(
                                                  'Order Information',
                                                  style: Get.theme.textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                    color: AppColors.textColor2,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Obx(() => PriceExpandTile(
                                                  netTotal: controller
                                                          .cartResponse1
                                                          .value
                                                          ?.netTotal
                                                          ?.toString() ??
                                                      '0',
                                                  wallet: '0',
                                                  tax: controller
                                                          .cartResponse1
                                                          .value
                                                          ?.tax ??
                                                      '0',
                                                  deliveryCharge: controller
                                                              .cartResponse1
                                                              .value
                                                              ?.deliveryCharge ==
                                                          '0'
                                                      ? 'FREE'
                                                      : controller
                                                              .cartResponse1
                                                              .value
                                                              ?.deliveryCharge
                                                              ?.toString() ??
                                                          '0',
                                                  grandTotal: controller
                                                          .cartResponse1
                                                          .value
                                                          ?.grandTotal
                                                          ?.toString() ??
                                                      '0',
                                                )),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // CustomPaint(
                                    //   painter: PointedDecorationPainter(),
                                    //   size: Size(
                                    //       MediaQuery.of(context).size.width,
                                    //       20),
                                    // ),
                                    const SizedBox(height: 30),
                                     Row(
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
                                  ],
                                ),
                              ),
                            ),
                            Obx(() => CurvedButton(
                                  isLoading: controller.loading.isTrue,
                                  onClick: () {
                                    controller.checkOut();
                                  },
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  text: 'CONFIRM ORDER',
                                  textColor: AppColors.textColor1,
                                  borderColor: AppColors.bottomSelectedColor,
                                  buttonColor: AppColors.bottomSelectedColor,
                                  borderRadius: 4.0,
                                  fontSize: 16,
                                  fontweight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                      controller.isLoading.value ? Loading() : SizedBox()
                    ],
                  ),
      ),
    );
  }
}






