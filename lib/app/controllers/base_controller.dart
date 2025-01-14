import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/app/core/utils/app_connectivity.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/colors.dart';
import '../core/values/constants.dart';
import '../data/api_provider.dart';
import '../modules/checkout/controller/chekout_controller.dart';
import '../modules/home/models/home_product_model.dart';
import '../routes/routes.dart';
import '../widgets/curve_button.dart';
import '../widgets/loading_widget.dart';

class NavigationController extends GetxController {

  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}

class BaseController extends GetxController {
  final source = {ConnectivityResult.none: false}.obs;
  final AppConnectivity _connectivity = AppConnectivity.instance;
  final selectedBottom = 0.obs;
  final isBottomNeeded = false.obs;
  final cartCount = 0.obs;
  final wishListCount = 0.obs;

//
  final addressLoading = false.obs;
  final addressListResponse = Rxn<AddressListResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  final sortItems = [
    'Price: Low to High',
    'Price: High to Low',
    'Name: A to Z',
    'Name: Z to A',
    'Top Rated',
    'Low Rated',
    'Popular'
  ];

  @override
  void onInit() {
    super.onInit();
    _connectivity.initialise();
    _connectivity.myStream.listen((source1) {
      source(source1);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  void getAddresses() async {
    var idToken = storageProvider.readLoginDetails();
    addressLoading.value = true;

    HomeAuth authData5 = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );
    try {
      final response = await authService.getAddress(authData5.toJson());
      addressLoading.value = false;
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          addressListResponse.value =
              AddressListResponse.fromJson(responseData);

          Get.snackbar('Success', 'Address Listed',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to list address',
              colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.textColor1, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      addressLoading.value = false;
      Get.snackbar('Error', 'Failed to load address: $e',
          colorText: AppColors.textColor1, backgroundColor: Colors.black);
    }
  }

  openAddressListBottomSheet({BuildContext? context}) {
    getAddresses();
    showModalBottomSheet(
      context: context ?? Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Material(
              elevation: 0.2,
              color: Get.theme.primaryColor,
              child: ListTile(
                title: const Text(
                  'Select Delivery Address',
                  style: TextStyle(
                    color: AppColors.textColor2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Text(
                  '+ADD ADDRESS',
                  style: TextStyle(
                    color: AppColors.bottomSelectedColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () async {
                  Get.back();
                  await Future.delayed(const Duration(milliseconds: 10));
                  await Get.toNamed(Routes.addressnew)!.then(
                    (value) => openAddressListBottomSheet(),
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => addressLoading.isTrue
                    ? const LoadingWidget()
                    : addressListResponse.value == null
                        ? const SizedBox()
                        : ListView.separated(
                            controller: scrollController,
                            itemCount:
                                addressListResponse.value!.addresses!.length,
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          addressListResponse
                                              .value!.addresses![index].name!,
                                          style: const TextStyle(
                                            color:
                                                AppColors.bottomSelectedColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            // InkWell(
                                            //   onTap: () async {
                                            //     Get.back();
                                            //     await Future.delayed(
                                            //         const Duration(
                                            //             milliseconds: 10));
                                            //     await Get.toNamed(
                                            //         Routes.addressnew,
                                            //         arguments: {
                                            //           'address':
                                            //           addressListResponse
                                            //               .value!
                                            //               .addresses![index]
                                            //         })!
                                            //         .then((value) =>
                                            //         openAddressListBottomSheet());
                                            //   },
                                            //   child: const Text(
                                            //     'EDIT',
                                            //     style: TextStyle(
                                            //       color: AppColors
                                            //           .bottomSelectedColor,
                                            //       fontSize: 15,
                                            //       fontWeight: FontWeight.w500,
                                            //     ),
                                            //   ),
                                            // ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CurvedButton(
                                              height: 24,
                                              width: 55,
                                              text: getAddressType(
                                                  addressListResponse
                                                      .value!
                                                      .addresses![index]
                                                      .addressType!),
                                              borderRadius: 0.0,
                                              textColor: AppColors.textColor2,
                                              fontSize: 12,
                                              fontweight: FontWeight.w500,
                                              borderColor:
                                                  AppColors.addressTypeText,
                                              buttonColor:
                                                  AppColors.addressTypeBox,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${addressListResponse.value!.addresses![index].address == null ? '' : '${addressListResponse.value!.addresses![index].address} ,'}${addressListResponse.value!.addresses![index].buildingNumber}, ${addressListResponse.value!.addresses![index].city}',
                                        style: const TextStyle(
                                          color: AppColors.bottomSelectedColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${addressListResponse.value!.addresses![index].state}, ${addressListResponse.value!.addresses![index].zipcode}, ${addressListResponse.value!.addresses![index].country!.name ?? ''}',
                                        style: const TextStyle(
                                          color: AppColors.bottomSelectedColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Mobile: ${addressListResponse.value!.addresses![index].mobile}',
                                        style: const TextStyle(
                                          color: AppColors.bottomSelectedColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CurvedButton(
                                      onClick: () async {
                                        Get.find<CheckoutScreenController>()
                                                .selectedAddress
                                                .value =
                                            addressListResponse
                                                .value!.addresses![index];
                                        Get.back();
                                        // if (Get.isRegistered<
                                        //     CheckoutScreenController>()) {
                                        //   Get.find<CheckoutScreenController>()
                                        //       .selectedAddress
                                        //       .value =
                                        //   addressListResponse
                                        //       .value!.addresses![index];
                                        //   Get.find<CheckoutScreenController>()
                                        //       .update();
                                        // }
                                        // if (Get.isRegistered<
                                        //     CartController>()) {
                                        //   Get.find<CartController>()
                                        //       .getCart(
                                        //     needLoading: true,
                                        //   )
                                        //       .then((value) async {
                                        //     if (Get.isRegistered<
                                        //         CheckoutScreenController>()) {
                                        //       Get.find<CheckoutScreenController>()
                                        //           .selectedAddress
                                        //           .value =
                                        //       addressListResponse
                                        //           .value!.addresses![index];
                                        //       Get.find<
                                        //           CheckoutScreenController>()
                                        //           .update();
                                        //     } else {
                                        //       await Get.toNamed(
                                        //         Routes.CHECKOUT_SCREEN,
                                        //         arguments: {
                                        //           'address': addressListResponse
                                        //               .value!.addresses![index],
                                        //           'cartResponse':
                                        //           Get.find<CartController>()
                                        //               .response
                                        //               .value,
                                        //         },
                                        //       );
                                        //     }
                                        //   });
                                        // }
                                      },
                                      borderRadius: 0,
                                      width: MediaQuery.of(context).size.width,
                                      textColor: AppColors.primary,
                                      buttonColor:
                                          AppColors.bottomSelectedColor,
                                      text: 'DELIVER HERE',
                                      fontSize: 16,
                                      fontweight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
