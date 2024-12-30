import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/constants.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/view/empty_cart.dart';
import 'package:ecommerce_app/app/modules/order_confirm/controller/order_confirm_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class OrderConfirmScreenView extends StatelessWidget {
  const OrderConfirmScreenView({super.key});

  @override
  Widget build(BuildContext context) {
final OrderConfirmScreenController controller = Get.put(OrderConfirmScreenController());
    return Scaffold(
      appBar:  CommonAppBar(
        toolBarTitle: 'Order Confirmation',
        showCart: false,
        showSearch: false,
        showWishList: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.primary,
                child: Column(
                  children: [
                    Image.asset(
                      ImageStrings.success,
                      height: 60,
                    ),
                    Image.asset(
                      ImageStrings.fullBag,
                      height: 130,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Thank you for shopping!',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your order has been placed.',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => controller.order.value != null
                          ? Text(
                              'Order Id : ${controller.order.value!.invoiceNumber!} ',
                              style: Get.theme.textTheme.bodyMedium!.copyWith(
                                color: AppColors.textColor2,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              ///seperator with decoration
              CustomPaint(
                painter: PointedDecorationPainter(),
                size: Size(MediaQuery.of(context).size.width, 20),
              ),
              const SizedBox(height: 30),
              Obx(
                () => controller.order.value == null
                    ? const SizedBox()
                    : controller.order.value!.shippingName == null
                        ? const SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.primary,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    'Delivering to :',
                                    style: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.cartProductTitle,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  title: Text(
                                    controller.order.value!.shippingName!,
                                    style: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.textColor2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  dense: true,
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${controller.order.value!.shippingAddress!} ${controller.order.value!.shippingCity!}\n${controller.order.value!.shippingCountry!}-${controller.order.value!.shippingZipcode!}',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.textColor2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  trailing: CurvedButton(
                                    height: 24,
                                    width: 55,
                                    text: getAddressType(controller
                                        .order.value!.shippingAddressType!),
                                    borderRadius: 0.0,
                                    textColor: AppColors.textColor2,
                                    fontSize: 12,
                                    fontweight: FontWeight.w500,
                                    borderColor: AppColors.addressTypeText,
                                    buttonColor: AppColors.addressTypeBox,
                                  ),
                                  isThreeLine: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 10));
                                    await Get.toNamed(Routes.bottombar);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Text(
                                      'ORDER DETAILS',
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.viewAll,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
              const SizedBox(
                height: 30,
              ),
              CurvedButton(
                onClick: () async {
                  await Get.offAllNamed(
                    Routes.bottombar,
                  );
                },
                height: 45,
                width: MediaQuery.of(context).size.width * 0.9,
                text: 'CONTINUE SHOPPING',
                textColor: AppColors.textColor1,
                borderColor: AppColors.bottomSelectedColor,
                buttonColor: AppColors.bottomSelectedColor,
                borderRadius: 4.0,
                fontSize: 16,
                fontweight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
