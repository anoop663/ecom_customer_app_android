import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/my_orders/controller/my_order_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    final MyOrdersController controller = Get.put(MyOrdersController());
    return Scaffold(
        appBar: CommonAppBar(
          toolBarTitle: 'My Orders',
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => controller.isLoading.isTrue
                ? const LoadingWidget()
                : controller.response.value == null
                    ? const EmptyOrders()
                    : controller.response.value!.result!.data!.isEmpty
                        ? const EmptyOrders()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            itemCount:
                                controller.response.value!.result!.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 230,
                                color: AppColors.primary,
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Order ID : ',
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                      color: AppColors.orderNo,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: controller
                                                        .response
                                                        .value!
                                                        .result!
                                                        .data![index]
                                                        .invoiceNumber!,
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                      color:
                                                          AppColors.textColor2,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              controller.response.value!.result!
                                                  .data![index].orderStatus!,
                                              style: Get
                                                  .theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                color: AppColors.orderStatus,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        CurvedButton(
                                          onClick: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 10));
                                            await Get.toNamed(
                                              Routes.home,
                                              arguments: {
                                                'order': controller
                                                    .response
                                                    .value!
                                                    .result!
                                                    .data![index],
                                              },
                                            );
                                          },
                                          text: 'Order Details',
                                          textColor: AppColors.textColor2,
                                          borderColor: AppColors.orderNo,
                                          height: 40,
                                          width: 150,
                                          borderRadius: 4,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .response
                                              .value!
                                              .result!
                                              .data![index]
                                              .itemsNew!
                                              .length,
                                          itemBuilder: (context, index1) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 100,
                                                child: Image.network(
                                                  ApiConfig.productImageUrl +
                                                      controller
                                                          .response
                                                          .value!
                                                          .result!
                                                          .data![index]
                                                          .itemsNew![index1]
                                                          .image!,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      ImageStrings.noImage,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              );
                            }),
          ),
        ));
  }
}

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          AnimationStrings.emptyBag,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Currently, you have no orders.\nStart shopping now!',
          style: Get.theme.textTheme.bodyMedium!.copyWith(
            color: AppColors.textColor2,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        CurvedButton(
          onClick: () async {
            await Future.delayed(const Duration(milliseconds: 10));
            await Get.toNamed(Routes.bestItems);
          },
          buttonColor: AppColors.bottomSelectedColor,
          text: 'Discover Our Products'.toUpperCase(),
          width: MediaQuery.of(context).size.width * 0.9,
          borderRadius: 4,
          fontweight: FontWeight.w500,
        ),
      ],
    );
  }
}
