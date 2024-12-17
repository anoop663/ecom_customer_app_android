import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/api_configs.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/curve_button.dart';
import '../controller/my_order_controller.dart';
import '../model/myorders_response.dart';

class OrderDetailsView extends GetView {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    Order? order;
    final arguments = Get.arguments;
    order = arguments['order'];
    return Scaffold(
      appBar: CommonAppBar(
        toolBarTitle: 'My Orders',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            order == null
                ? const SizedBox()
                : RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order ID : ',
                          style: Get.theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.orderNo,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: order.invoiceNumber!,
                          style: Get.theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textColor2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                  itemCount: order?.itemsNew!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: CurvedButton(
                        onClick: () async {
                          // await Future.delayed(
                          //     const Duration(milliseconds: 10));
                          // Get.toNamed(
                          //   Routes.SINGLE_ORDER_DETAILS,
                          //   arguments: {
                          //     'order': controller.order.value,
                          //     'item':
                          //     controller.order.value!.itemsNew![index],
                          //   },
                          // );
                        },
                        height: MediaQuery.of(context).size.height * 0.185,
                        width: MediaQuery.of(context).size.width,
                        borderColor: AppColors.cartItemBorder,
                        borderRadius: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * (0.35),
                                child: Image.network(
                                  ApiConfig.productImageUrl +
                                      order!.itemsNew![index].image!,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * (0.45),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.56,
                                      height: 20,
                                      child: Text(
                                        order.itemsNew![index].productName!,
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.cartProductTitle,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      order.storeName!,
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.cartProductSubTitle,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (order.items![index].product
                                            ?.thisOptions !=
                                        null)
                                      SizedBox(
                                        height: order.items![index].product!
                                                .thisOptions!.length *
                                            20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: order.items![index]
                                              .product!.thisOptions!.length,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                '${order?.items![index].product!.thisOptions![i].name!.name} ${order?.items![index].product!.thisOptions![i].thisValues != null ? order?.items![index].product!.thisOptions![i].thisValues!.text : ''}',
                                                style: Get
                                                    .theme.textTheme.bodyMedium!
                                                    .copyWith(
                                                  color: AppColors.textColor2,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
                                          order.updatedAt
                                              .toString()
                                              .substring(0, 19),
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.orderDetailDate,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///order status
                                    Container(
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: AppColors.orderDetailStatusBg,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          order.orderStatus!,
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.orderDetailStatus,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              // Image.asset(
                              //   IconStrings.rightArrow,
                              //   height: 18,
                              //   color: AppColors.textColor2,
                              // ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
