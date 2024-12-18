import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../core/values/colors.dart';
import '../../../routes/routes.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/curve_button.dart';
import '../../../widgets/loading_widget.dart';
import '../controllers/confirm_cancel_controller.dart';

class ConfirmCancelView extends GetView<ConfirmCancelController> {
  const ConfirmCancelView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CommonAppBar(
        toolBarTitle: 'Confirmation',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: Image.asset(
            //     ImageStrings.logoBigTransparent,
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Order 1 #',
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.orderNo,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: controller.orderId.value.toString(),
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.textColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    controller.response.value == null
                        ? controller.isReturn.isFalse
                            ? 'Are you sure want to cancel?'
                            : 'Are you sure want to return?'
                        : controller.response.value!.success == 1
                            ? controller.isReturn.isFalse
                                ? 'Cancellation Successful'
                                : 'Return Successful'
                            : controller.isReturn.isFalse
                                ? 'Cancellation might be failed.Please check again'
                                : 'Return might be failed.Please check again',
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.orderNo,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Obx(() => controller.confirm.isTrue
                //     ? Text(
                //         'Lorem ipsum dolor sit amet consectetur.Tincidunt nec\nconsequat enim ipsum luctus placerat. Rhoncus tempus\nimperdiet mi facilisis sit neque elit. Nunc pharetra suscipit\nadipiscing in proin neque.',
                //         style: Get.theme.textTheme.bodyMedium!.copyWith(
                //           color: AppColors.orderNo,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400,
                //         ),
                //         textAlign: TextAlign.center,
                //       )
                //     : SizedBox()),
                const Spacer(),
                Obx(
                  () => controller.confirm.isTrue
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CurvedButton(
                            onClick: () {
                              Get.offAllNamed(Routes.account);
                              controller.confirm.value = false;
                            },
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            text: 'OK, GOT IT',
                            textColor: AppColors.textColor1,
                            borderColor: AppColors.bottomSelectedColor,
                            buttonColor: AppColors.bottomSelectedColor,
                            borderRadius: 4.0,
                          ),
                        )
                      : Container(
                          height: 65,
                          decoration: const BoxDecoration(
                              color: AppColors.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(10, 0, 0, 0),
                                  offset: Offset(0, 2),
                                  blurRadius: 9,
                                  spreadRadius: 3,
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CurvedButton(
                                  onClick: () {
                                    Get.back();
                                  },
                                  text: 'Back',
                                  child: Center(
                                    child: Text(
                                      'Back'.toUpperCase(),
                                      style: Get.theme.textTheme.titleMedium!
                                          .copyWith(
                                        color: AppColors.textColor2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Expanded(
                                  child: CurvedButton(
                                    onClick: () {
                                      controller.isReturn.isFalse
                                          ? controller.cancelOrder()
                                          : controller.returnOrder();
                                    },
                                    borderRadius: 4.0,
                                    height: 50,
                                    buttonColor: AppColors.bottomSelectedColor,
                                    text: 'addToCart.tr',
                                    child: controller.loading.isTrue
                                        ? const LoadingWidget()
                                        : Center(
                                            child: Text(
                                              'CONFIRM'.toUpperCase(),
                                              style: Get
                                                  .theme.textTheme.titleMedium!
                                                  .copyWith(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
