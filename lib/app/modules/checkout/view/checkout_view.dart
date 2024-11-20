import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/address_manage/controller/address_list_controller.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/modules/cart/model/cart_response_model.dart';
import 'package:ecommerce_app/app/modules/cart/view/empty_cart.dart';
import 'package:ecommerce_app/app/modules/checkout/controller/chekout_controller.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/add_radiobox.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/curved_box.dart';
import 'package:ecommerce_app/app/widgets/curved_container_icon.dart';
import 'package:ecommerce_app/app/widgets/custom_expand.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:ecommerce_app/app/widgets/price_summery.dart';
import 'package:ecommerce_app/app/widgets/support_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class CheckoutScreenView extends StatelessWidget {
  const CheckoutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutScreenController controller =
        Get.put(CheckoutScreenController());

    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: CommonAppBar(
        toolBarTitle:
            'Payment: ₹ ${cartController.cartResponse.value?.grandTotal ?? '0'}',
        showCart: false,
        showSearch: false,
        showWishList: false,
      ),
      body: Obx(
        () => cartController.cartResponse.value == null
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
            : SizedBox(
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
                            Obx(() => AddressExpandTile(
                                  address: controller.selectedAddress.value,
                                )),
                            const SizedBox(height: 20),
                            Obx(() => ItemsExpandTile(
                                  items: controller
                                          .cartResponse1.value?.products ??
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
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CurvedBox(
                                      child: Column(
                                        children: [
                                          Obx(() => CheckboxExpansionTile(
                                                onChanged: (value) {
                                                  controller.paymentMode.value =
                                                      value;
                                                },
                                                modes: controller.cartResponse1
                                                    .value?.paymentModes,
                                              )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'Order Information',
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.textColor2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CurvedBox(
                                      child: Obx(() => PriceExpandTile(
                                            netTotal: controller.cartResponse1
                                                    .value?.netTotal
                                                    ?.toString() ??
                                                '0',
                                            wallet: '0',
                                            tax: controller
                                                    .cartResponse1.value?.tax ??
                                                '0',
                                            deliveryCharge: controller
                                                        .cartResponse1
                                                        .value
                                                        ?.deliveryCharge ==
                                                    '0'
                                                ? 'FREE'
                                                : controller.cartResponse1.value
                                                        ?.deliveryCharge
                                                        ?.toString() ??
                                                    '0',
                                            grandTotal: controller.cartResponse1
                                                    .value?.grandTotal
                                                    ?.toString() ??
                                                '0',
                                          )),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            CustomPaint(
                              painter: PointedDecorationPainter(),
                              size: Size(MediaQuery.of(context).size.width, 20),
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SupportIcon(
                                  icon: IconStrings.cartExtra1,
                                  title: '100% SECURE\nPAYMENTS',
                                  backgroundColor: AppColors.transparent,
                                  fontColor: AppColors.cartExtraText,
                                  imageSize: 45,
                                ),
                                SupportIcon(
                                  icon: IconStrings.cartExtra2,
                                  title: 'EASY RETURNS & QUICK\nREFUNDS',
                                  backgroundColor: AppColors.transparent,
                                  fontColor: AppColors.cartExtraText,
                                  imageSize: 45,
                                ),
                                SupportIcon(
                                  icon: IconStrings.cartExtra3,
                                  title: 'QUALITY\nASSURANCE',
                                  backgroundColor: AppColors.transparent,
                                  fontColor: AppColors.cartExtraText,
                                  imageSize: 45,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => controller.loading.isTrue
                        ? const LoadingWidget()
                        : CurvedButton(
                            onClick: () {
                              controller.checkout();
                            },
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.9,
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
      ),
    );
  }
}

class AddressExpandTile extends StatefulWidget {
  const AddressExpandTile({super.key, required this.address});
  final Address address;

  @override
  State<AddressExpandTile> createState() => _AddressExpandTileState();
}

class _AddressExpandTileState extends State<AddressExpandTile> {
  bool addressTileOpen = false;
  MyAddressListController controller1 = Get.put(MyAddressListController());
  //var address1=controller1.addressresponse.value!.addresses;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      elevation: 0.0,
      expandedHeaderPadding: EdgeInsets.zero,
      disabledColor: AppColors.textColor2,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          addressTileOpen = !addressTileOpen;
        });
      },
      animationDuration: const Duration(milliseconds: 700),
      children: [
        CustomExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(
                children: [
                  CurvedButton(
                    height: 24,
                    width: 55,
                    text: controller1.address.value!.addressType,
                    borderRadius: 0.0,
                    textColor: AppColors.textColor2,
                    fontSize: 12,
                    fontweight: FontWeight.w500,
                    borderColor: AppColors.addressTypeText,
                    buttonColor: AppColors.addressTypeBox,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    controller1.address.value!.name ?? '',
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.removeButton,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  addressTileOpen = !addressTileOpen;
                });
              },
            );
          },
          canTapOnHeader: true,
          body: Column(
            children: [
              ListTile(
                title: Text(
                  controller1.address.value!.name ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                dense: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '${controller1.address.value!.address ?? ''}\n${controller1.address.value!.city ?? ''}\n${controller1.address.value!.state ?? ''}\n${controller1.address.value!.zipcode ?? ''}',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                trailing: InkWell(
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 10));
                    await Get.toNamed(Routes.home,
                        arguments: {'address': widget.address});
                  },
                  child: Text(
                    'Edit',
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.bottomSelectedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                isThreeLine: true,
              ),
              InkWell(
                onTap: () {
                  // Optional functionality for changing address
                },
                child: Text(
                  'CHANGE ADDRESS',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.bottomSelectedColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          isExpanded: addressTileOpen,
        ),
      ],
    );
  }
}

class CheckboxExpansionTile extends StatefulWidget {
  const CheckboxExpansionTile({
    super.key,
    required this.modes,
    required this.onChanged,
  });
  final List<PaymentMode>? modes;
  final Function(int value) onChanged;
  @override
  State<CheckboxExpansionTile> createState() => _CheckboxExpansionTileState();
}

class _CheckboxExpansionTileState extends State<CheckboxExpansionTile> {
  bool addressTileOpen = false;
  int selectedMode = 4;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      elevation: 0.0,
      expandedHeaderPadding: EdgeInsets.zero,
      disabledColor: AppColors.textColor2,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          addressTileOpen = !addressTileOpen;
        });
      },
      animationDuration: const Duration(milliseconds: 700),
      children: [
        CustomExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(
                children: [
                  Text(
                    'Select a Payment Method',
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.removeButton,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  addressTileOpen = !addressTileOpen;
                });
              },
            );
          },
          canTapOnHeader: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                widget.modes == null
                    ? const AppRadioTextButton(
                        text: 'Cash On Delivery',
                        isSelected: true,
                        selectedTextColor: AppColors.bottomSelectedColor,
                        unSelectedTextColor: AppColors.bottomNotSelectedColor,
                        unSelectedButtonColor: AppColors.bottomNotSelectedColor,
                        selectedButtonColor: AppColors.bottomSelectedColor,
                      )
                    : ListView.separated(
                        itemCount: widget.modes!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AppRadioTextButton(
                            onTap: () {
                              setState(() {
                                selectedMode = widget.modes![index].id!;
                                widget.onChanged(selectedMode);
                              });
                            },
                            text: widget.modes![index].mode!,
                            isSelected: selectedMode == widget.modes![index].id,
                            selectedTextColor: AppColors.bottomSelectedColor,
                            unSelectedTextColor:
                                AppColors.bottomNotSelectedColor,
                            unSelectedButtonColor:
                                AppColors.bottomNotSelectedColor,
                            selectedButtonColor: AppColors.bottomSelectedColor,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 30,
                            indent: 10,
                            endIndent: 10,
                          );
                        },
                      )
              ],
            ),
          ),
          isExpanded: addressTileOpen,
        ),
      ],
    );
  }
}

class ItemsExpandTile extends StatefulWidget {
  const ItemsExpandTile({
    super.key,
    required this.items,
  });
  final List<Product> items;

  @override
  State<ItemsExpandTile> createState() => _ItemsExpandTileState();
}

class _ItemsExpandTileState extends State<ItemsExpandTile> {
  bool addressTileOpen = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      elevation: 0.0,
      expandedHeaderPadding: EdgeInsets.zero,
      disabledColor: AppColors.textColor2,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          addressTileOpen = !addressTileOpen;
        });
      },
      animationDuration: const Duration(milliseconds: 700),
      children: [
        CustomExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'ITEMS (${widget.items.length})',
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.removeButton,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                setState(() {
                  addressTileOpen = !addressTileOpen;
                });
              },
            );
          },
          canTapOnHeader: true,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                CurvedBox(
                  borderRadius: 8.0,
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CurvedContainerWithImage(
                                  height: 100,
                                  width: 80,
                                  containerImage: widget.items.single.image,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.64,
                                  height: 15,
                                  child: Text(
                                    widget.items[index].name!,
                                    style: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.textColor2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.items[index].manufacturer ?? '',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${widget.items[index].symbolLeft} ${widget.items[index].price!} ${widget.items[index].symbolRight!}',
                                      style: Get.theme.textTheme.bodyMedium!
                                          .copyWith(
                                        color: AppColors.textColor2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (widget.items[index].price !=
                                        widget.items[index].oldprice)
                                      Text(
                                        '${widget.items[index].symbolLeft} ${widget.items[index].oldprice!} ${widget.items[index].symbolRight!}',
                                        style: Get.theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.textColor2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.items[index].purchaseReward ?? '',
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.orderDetailStatus,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          isExpanded: addressTileOpen,
        ),
      ],
    );
  }
}

class PriceExpandTile extends StatefulWidget {
  final String netTotal;
  final String wallet;
  final String tax;
  final String deliveryCharge;
  final String grandTotal;

  const PriceExpandTile({
    super.key,
    required this.netTotal,
    required this.wallet,
    required this.tax,
    required this.deliveryCharge,
    required this.grandTotal,
  });
  @override
  State<PriceExpandTile> createState() => _PriceExpandTileState();
}

class _PriceExpandTileState extends State<PriceExpandTile> {
  bool addressTileOpen = false;
  final CartController cartController =
      Get.find<CartController>(); // Access CartController

  @override
  void initState() {
    super.initState();
    // Fetch cart data on initialization
    cartController.viewCart();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartResponse = cartController.cartResponse.value;

      // Check if cart data is available
      if (cartResponse == null) {
        return Center(child: CircularProgressIndicator());
      }

      // Retrieve values from cartResponse
      final netTotal = cartResponse.netTotal ?? '0';
      final grandTotal = cartResponse.grandTotal ?? '0';
      final tax = cartResponse.tax ?? '0';
      final deliveryCharge = cartResponse.deliveryCharge ?? 'FREE';

      return CustomExpansionPanelList(
        elevation: 0.0,
        expandedHeaderPadding: EdgeInsets.zero,
        disabledColor: AppColors.textColor2,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            addressTileOpen = !addressTileOpen;
          });
        },
        animationDuration: const Duration(milliseconds: 700),
        children: [
          CustomExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                minLeadingWidth: 10,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Details',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.removeButton,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  '₹ $netTotal',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  setState(() {
                    addressTileOpen = !addressTileOpen;
                  });
                },
              );
            },
            canTapOnHeader: true,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  PriceSummaryItem(
                    title: 'Grand Total',
                    subTitle: '₹ $grandTotal ₹',
                  ),
                  const SizedBox(height: 10),
                  PriceSummaryItem(
                    title: 'VAT',
                    subTitle: '₹ $tax',
                  ),
                  const SizedBox(height: 10),
                  PriceSummaryItem(
                    title: 'Shipping Charges',
                    subTitle: deliveryCharge != 'FREE'
                        ? '₹ $deliveryCharge'
                        : deliveryCharge,
                  ),
                  const SizedBox(height: 10),
                  PriceSummaryItem(
                    title: 'You Pay',
                    subTitle: '₹ $netTotal',
                    fontsize: 16,
                    fontweight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            isExpanded: addressTileOpen,
          ),
        ],
      );
    });
  }
}
