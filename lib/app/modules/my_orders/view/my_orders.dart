import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/core/values/strings.dart';
import 'package:soulstyle/app/modules/my_orders/controller/my_order_controller.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:soulstyle/app/widgets/app_bar.dart';
import 'package:soulstyle/app/widgets/curve_button.dart';
import 'package:soulstyle/app/widgets/loading_widget.dart';
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
                    : (controller.response.value?.result?.data?.length ?? 0) < 0
                        ? const EmptyOrders()
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: controller
                                    .response.value?.result?.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Order ${index + 1} # ',
                                                      style: Get.theme.textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                        color:
                                                            AppColors.orderNo,
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
                                                        color: AppColors
                                                            .textColor2,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            CurvedButton(
                                              onClick: () async {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => OrderDetailsView()),
                                                // );
                                                // await Future.delayed(
                                                //     const Duration(
                                                //         milliseconds: 10));
                                                await Get.toNamed(
                                                  Routes.ordersDetails,
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
                                              height: 34,
                                              width: 110,
                                              borderRadius: 4,
                                            )
                                          ],
                                        ),
                                        Text(
                                          controller.response.value!.result!
                                              .data![index].orderStatus!,
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.orderStatus,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 20,
                                            ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller
                                            .response
                                            .value!
                                            .result!
                                            .data![index]
                                            .itemsNew!
                                            .length,
                                        itemBuilder: (context, index1) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              // height: 95,
                                              width: 80,
                                              ApiConfig.productImageUrl +
                                                  controller
                                                      .response
                                                      .value!
                                                      .result!
                                                      .data![index]
                                                      .itemsNew![index1]
                                                      .image!,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  ImageStrings.noImage,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                  )
                                ],
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
