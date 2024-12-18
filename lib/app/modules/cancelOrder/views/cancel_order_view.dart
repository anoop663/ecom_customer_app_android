import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../core/values/api_configs.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../../routes/routes.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/curve_button.dart';
import '../../../widgets/curved_box.dart';
import '../controllers/cancel_order_controller.dart';

class CancelOrderView extends GetView<CancelOrderController> {
  const CancelOrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          toolBarTitleWidget: Obx(
            () => Text(
              controller.isReturn.isFalse ? 'Cancel Orders' : 'Retrun Orders',
              style: const TextStyle(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => controller.item.value != null
                              ? Image.network(
                                  ApiConfig.productImageUrl +
                                      controller.item.value!.image!,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(ImageStrings.noImage);
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        'Reason for ${controller.isReturn.isFalse ? 'cancellation*' : 'return*'} ',
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textColor2,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CurvedBox(
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.primary,
                          child: Column(
                            children: [
                              Material(
                                elevation: 0.2,
                                color: Get.theme.primaryColor,
                                child: ListTile(
                                  trailing: const Icon(
                                    Icons.close,
                                    color: AppColors.textColor2,
                                  ),
                                  title: const Text(
                                    'Select Reason',
                                    style: TextStyle(
                                      color: AppColors.textColor2,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.reasons.length,
                                    itemBuilder: (context, i) {
                                      return Obx(
                                        () => CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          title: Text(
                                            controller.reasons[i],
                                            style: Get
                                                .theme.textTheme.bodyMedium!
                                                .copyWith(
                                              color: AppColors.textColor2,
                                            ),
                                          ),
                                          value:
                                              controller.selectedReason.value ==
                                                  controller.reasons[i],
                                          onChanged: (value) {
                                            if (controller
                                                    .selectedReason.value ==
                                                controller.reasons[i]) {
                                              controller.selectedReason('');
                                            } else {
                                              controller.selectedReason(
                                                  controller.reasons[i]);
                                            }
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    trailing: Image.asset(
                      IconStrings.downArrow,
                      height: 8,
                      color: AppColors.summaryTitle,
                    ),
                    title: Obx(() => Text(
                          controller.selectedReason.value != ''
                              ? controller.selectedReason.value
                              : 'Select Reason',
                          style: Get.theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.summaryTitle,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Other details',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CurvedBox(
                  minHeight: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: controller.commentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 200,
                      decoration: InputDecoration(
                        counterText: '',
                        isDense: true,
                        hintText: 'Any other comments',
                        hintStyle: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.summaryTitle,
                        ),
                      ),
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.summaryTitle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListenableBuilder(
                        listenable: controller.commentController,
                        builder: (context, snapshot) {
                          return Text(
                            '${controller.commentController.text.length}/200',
                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.textColor2,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                  ],
                ),
                Obx(
                  () => controller.isReturn.isFalse
                      ? const SizedBox()
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Account holder name*',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CurvedBox(
                              minHeight: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextField(
                                  controller: controller.accountNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter name',
                                    hintStyle: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.summaryTitle,
                                    ),
                                  ),
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.summaryTitle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'IFSC code*',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CurvedBox(
                              minHeight: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextField(
                                  controller: controller.accountIFSCcontroller,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter code',
                                    hintStyle: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.summaryTitle,
                                    ),
                                  ),
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.summaryTitle,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Account number*',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CurvedBox(
                              minHeight: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextField(
                                  controller:
                                      controller.accountNumbercontroller,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter acc number',
                                    hintStyle: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.summaryTitle,
                                    ),
                                  ),
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.summaryTitle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() => CurvedButton(
                      onClick: controller.selectedReason.value == ''
                          ? null
                          : () async {
                              if (controller.validate()) {
                                await Future.delayed(
                                    const Duration(milliseconds: 10));
                                await Get.toNamed(
                                  Routes.confirmCancel,
                                  arguments: {
                                    'order_id':
                                        controller.order.value!.id!.toString(),
                                    'item_id':
                                        controller.item.value!.id!.toString(),
                                    'reason': controller.selectedReason.value,
                                    'isReturn': controller.isReturn.value,
                                    'account_number': controller
                                        .accountNumbercontroller.value.text,
                                    'account_name': controller
                                        .accountNameController.value.text,
                                    'ifsc': controller
                                        .accountIFSCcontroller.value.text,
                                  },
                                );
                              }
                            },
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      text: controller.isReturn.isFalse
                          ? 'CANCEL ORDER'
                          : 'RETURN ORDER',
                      textColor: AppColors.textColor1,
                      borderColor: controller.selectedReason.value != ''
                          ? AppColors.bottomSelectedColor
                          : AppColors.summaryTitle,
                      buttonColor: controller.selectedReason.value != ''
                          ? AppColors.bottomSelectedColor
                          : AppColors.summaryTitle,
                      borderRadius: 4.0,
                    )),
              ],
            )),
          ),
        ));
  }
}
