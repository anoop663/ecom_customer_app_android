import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/api_configs.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/constants.dart';
import '../../../core/values/strings.dart';
import '../../../routes/routes.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/curve_button.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/price_summery.dart';
import '../../my_orders/controller/my_order_controller.dart';
import '../controllers/single_order_details_controller.dart';

class SingleOrderDetailsView extends GetView<SingleOrderDetailsController> {
  // ignore: use_super_parameters
  const SingleOrderDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        toolBarTitle: 'My Orders',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => controller.loading.isTrue
              ? const LoadingWidget()
              : controller.order.value == null
                  ? const SizedBox()
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ///order id and time
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: controller
                                            .order.value!.invoiceNumber,
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.textColor2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'OrderPlaced ',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.orderNo,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: Get.find<MyOrdersController>()
                                            .formatDate(controller
                                                .order.value!.createdAt!),

                                        // controller.order.value!.createdAt!
                                        //     .toString()
                                        //     .substring(0, 16),
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.textColor2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///product
                            CurvedButton(
                              height:
                                  MediaQuery.of(context).size.height * 0.185,
                              width: MediaQuery.of(context).size.width * 0.9,
                              borderColor: AppColors.cartItemBorder,
                              buttonColor: AppColors.primary,
                              borderRadius: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        (0.35),
                                    child: Image.network(
                                      ApiConfig.productImageUrl +
                                          controller.item.value!.image!,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            ImageStrings.noImage);
                                      },
                                    ),
                                  ),
                                  // Image.asset(
                                  //   ImageStrings.product1,
                                  //   height: MediaQuery.of(context).size.height *
                                  //       0.16,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        (0.45),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  (0.45),
                                              child: Text(
                                                controller
                                                    .item.value!.productName!,
                                                style: Get
                                                    .theme.textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: AppColors
                                                      .cartProductTitle,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              controller
                                                      .order.value!.storeName ??
                                                  '',
                                              style: Get
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                color: AppColors
                                                    .cartProductSubTitle,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            // Text(
                                            //   'Size : L',
                                            //   style: Get
                                            //       .theme.textTheme.bodyMedium!
                                            //       .copyWith(
                                            //     color: AppColors.textColor2,
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.w400,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '₹ ${controller.item.value!.amount!}',
                                                  style: Get.theme.textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                    color: AppColors.textColor2,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 5,
                                                // ),
                                                // Text(
                                                //   'OMR 5.000',
                                                //   style: Get
                                                //       .theme.textTheme.bodyMedium!
                                                //       .copyWith(
                                                //     color: AppColors
                                                //         .orderDetailOldPrice,
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.w400,
                                                //     decoration: TextDecoration
                                                //         .lineThrough,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            // Text(
                                            //   'You saved OMR 2.000',
                                            //   style: Get
                                            //       .theme.textTheme.bodyMedium!
                                            //       .copyWith(
                                            //     color:
                                            //         AppColors.orderDetailStatus,
                                            //     fontSize: 10,
                                            //     fontWeight: FontWeight.w400,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              IconStrings.deliveryVehicle,
                                              height: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              Get.find<MyOrdersController>()
                                                  .formatDate(controller.item.value!.createdAt.toString()),
                                              // controller.item.value!.createdAt!
                                              //     .toString()
                                              //     .substring(0, 16),
                                              style: Get
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                color:
                                                    AppColors.orderDetailDate,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
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
                            const SizedBox(
                              height: 20,
                            ),

                            ///order status

                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.cartItemBorder,
                                ),
                                color: AppColors.primary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          'Order Status',
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: AppColors.accessoriesColor1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  Obx(
                                    () => controller.loading.isTrue
                                        ? const SizedBox()
                                        : controller.trackResponse.value == null
                                            ? const SizedBox()
                                            : ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .trackResponse
                                                    .value!
                                                    .data!
                                                    .timeline!
                                                    .length,
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 15.0),
                                                itemBuilder: (context, index) {
                                                  return Row(
                                                    children: [
                                                      AnimatedCrossFade(
                                                        duration:
                                                            const Duration(
                                                                seconds: 1),
                                                        crossFadeState: controller
                                                                    .trackResponse
                                                                    .value!
                                                                    .data!
                                                                    .timeline![
                                                                        index]
                                                                    .status !=
                                                                1
                                                            ? CrossFadeState
                                                                .showFirst
                                                            : CrossFadeState
                                                                .showSecond,
                                                        firstChild:
                                                            const CurvedButton(
                                                          width: 25,
                                                          height: 25,
                                                          borderColor: AppColors
                                                              .orderDetailStepperNotSelectedBorder,
                                                          buttonColor: AppColors
                                                              .orderDetailStepperNotSelected,
                                                        ),
                                                        secondChild:
                                                            CurvedButton(
                                                          width: 25,
                                                          height: 25,
                                                          borderColor: AppColors
                                                              .orderDetailStepperSelectedBorder,
                                                          buttonColor: AppColors
                                                              .orderDetailStepperSelected,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Image.asset(
                                                              IconStrings
                                                                  .checked,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        controller
                                                            .trackResponse
                                                            .value!
                                                            .data!
                                                            .timeline![index]
                                                            .statushistory!
                                                            .statusText!,
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .orderDetailStepperNotSelectedText,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 11,
                                                        ),
                                                        Container(
                                                          height: 15,
                                                          width: 3,
                                                          color: AppColors
                                                              .orderDetailStepperNotSelectedBorder,
                                                        ),
                                                      ],
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

                            ///address
                            CurvedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CurvedButton(
                                      height: 24,
                                      width: 55,
                                      text: getAddressType(controller
                                          .order.value!.shippingAddressType!),
                                      borderRadius: 4.0,
                                      textColor: AppColors.textColor2,
                                      fontSize: 12,
                                      fontweight: FontWeight.w500,
                                      borderColor: AppColors.addressTypeText,
                                      buttonColor: AppColors.addressTypeBox,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          controller.order.value!.shippingName!,
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '|',
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .order.value!.shippingPhone!,
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${controller.order.value!.shippingAddress}, ${controller.order.value!.shippingAreaNumber}, ${controller.order.value!.shippingCity}, ${controller.order.value!.shippingCountry}  - ${controller.order.value!.shippingZipcode}',
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.textColor2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///payment summary
                            CurvedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PAYMENT SUMMARY',
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.summaryTitle,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // PriceSummaryItem(
                                    //     title: 'Bag Total (ex of tax)',
                                    //     subTitle: currency.tr +
                                    //         ' ' +
                                    //         controller.item.value!
                                    //             .amount!),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    PriceSummaryItem(
                                      title: 'Price',
                                      subTitle:
                                          '₹ ${controller.item.value?.nonTaxAmount ?? ''}',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    PriceSummaryItem(
                                      title: 'Tax',
                                      subTitle:
                                          '₹ ${controller.item.value!.taxAmount!}',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: AppColors.cartItemBorder,
                                      thickness: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    PriceSummaryItem(
                                      title: 'Total Amount',
                                      subTitle:
                                          '₹ ${controller.item.value!.amount!}',
                                      fontsize: 14,
                                      fontweight: FontWeight.w500,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => controller.item.value == null
                                  ? const SizedBox()
                                  : controller.item.value!.possibleAction == 0
                                      ? const SizedBox()
                                      : CurvedButton(
                                          onClick: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 10));

                                            await Get.toNamed(
                                              // controller.item.value!.possibleAction==1?
                                              // possible action  = 0 -> no action possible
                                              // possible action  = 1 -> cancel action possible
                                              // possible action  = 2 -> return action possible
                                              Routes.cancelOrderView,
                                              arguments: {
                                                'order': controller.order.value,
                                                'item': controller.item.value,
                                                'isReturn': controller
                                                        .item
                                                        .value!
                                                        .possibleAction ==
                                                    2,
                                              },
                                            );
                                          },
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          text: controller.item.value!
                                                      .possibleAction ==
                                                  1
                                              ? 'CANCEL ORDER'
                                              : 'RETURN ORDER',
                                          textColor: AppColors.textColor2,
                                          borderColor: AppColors.cartItemBorder,
                                          buttonColor: AppColors.primary,
                                          borderRadius: 4.0,
                                        ),
                            ),

                            const SizedBox(
                              height: 30,
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

class CurvedBox extends StatelessWidget {
  const CurvedBox({
    super.key,
    this.height,
    this.minHeight,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.boxColor,
    this.child,
  });
  final double? height, width, borderRadius, minHeight;
  final Color? borderColor, boxColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.cartItemBorder,
        ),
        color: boxColor ?? AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
      ),
      child: child,
    );
  }
}
