import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/address_manage/controller/address_list_controller.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/curved_box.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyAddressListView extends StatelessWidget {
  const MyAddressListView({super.key});
  @override
  Widget build(BuildContext context) {
    MyAddressListController controller = Get.put(MyAddressListController());
    return Scaffold(
      appBar: CommonAppBar(
        toolBarTitle: 'MY ADDRESSES',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => controller.loading.isTrue
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => controller.addressresponse.value == null
                            ? Container()
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 20.0),
                                itemCount: controller
                                    .addressresponse.value!.addresses!.length,
                                itemBuilder: (context, index) {
                                  return AddressBox(
                                    address: controller.addressresponse.value!
                                        .addresses![index],
                                  );
                                },
                              ),
                      ),
                      InkWell(
                        onTap: () async {
                         
                          await Get.toNamed(Routes.addressnew);
                        },
                        child: CurvedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  IconStrings.plusIcon,
                                  color: AppColors.bottomSelectedColor,
                                  height: 25,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ADD NEW ADDRESS',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.bottomSelectedColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class AddressBox extends StatelessWidget {
  final Address address;

  const AddressBox({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final MyAddressListController controller =
        Get.find<MyAddressListController>();

    return Column(
      children: [
        CurvedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address.name ?? 'Unknown',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CurvedButton(
                      height: 24,
                      width: 55,
                      text: address.addressType == '0'
                          ? 'Home'
                          : address.addressType == '1'
                              ? 'Office'
                              : 'Other',
                      borderRadius: 4.0,
                      textColor: AppColors.textColor2,
                      fontSize: 12,
                      fontweight: FontWeight.w500,
                      borderColor: AppColors.addressTypeText,
                      buttonColor: AppColors.addressTypeBox,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${address.buildingNumber ?? ''}, ${address.areaNumber ?? ''}, ${address.city ?? ''}',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '${address.country!.name ?? 'No Country'}, ${address.zipcode ?? 'No Zipcode'}',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Contact Number: ${address.mobile ?? 'N/A'}',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => controller.tempAddressId.value == address.id.toString()
                      ? const LoadingWidget()
                      : RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Edit',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await Get.toNamed(
                                      Routes.address,
                                      arguments: {'address': address},
                                    );
                                  },
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.bottomSelectedColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '  |  ',
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.bottomSelectedColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Remove',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    //  controller.removeAddress(address.id.toString());
                                  },
                                style: Get.theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.bottomSelectedColor,
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
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
