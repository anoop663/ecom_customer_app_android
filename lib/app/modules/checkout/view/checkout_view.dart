import 'package:ecommerce_app/app/core/values/strings.dart';
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
        () => controller.initialLoading.isTrue
            ? const Center(child: LoadingWidget())
            : cartController.cartResponse.value == null
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
                                Obx(
                                  () => AddressExpandTile(
                                      address:
                                          controller.selectedAddress.value),
                                ),
                                const SizedBox(height: 20),
                                Obx(() => ItemsExpandTile(
                                      items: cartController
                                              .cartResponse.value?.products ??
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
                                              style: Get
                                                  .theme.textTheme.bodyMedium!
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
                                                      controller.paymentMode
                                                          .value = value;
                                                    },
                                                    modes: controller
                                                        .cartResponse1
                                                        .value
                                                        ?.paymentModes,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              'Order Information',
                                              style: Get
                                                  .theme.textTheme.bodyMedium!
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
                                                netTotal: controller
                                                        .cartResponse1
                                                        .value
                                                        ?.netTotal
                                                        ?.toString() ??
                                                    '0',
                                                wallet: '0',
                                                tax: controller.cartResponse1
                                                        .value?.tax ??
                                                    '0',
                                                deliveryCharge: controller
                                                            .cartResponse1
                                                            .value
                                                            ?.deliveryCharge ==
                                                        '0'
                                                    ? 'FREE'
                                                    : controller
                                                            .cartResponse1
                                                            .value
                                                            ?.deliveryCharge
                                                            ?.toString() ??
                                                        '0',
                                                grandTotal: controller
                                                        .cartResponse1
                                                        .value
                                                        ?.grandTotal
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
                                  size: Size(
                                      MediaQuery.of(context).size.width, 20),
                                ),
                                const SizedBox(height: 30),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                  controller.checkOut();
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
  //MyAddressListController controller1 = Get.put(MyAddressListController());

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
                    text: widget.address.addressType == '0'
                        ? 'Home'
                        : widget.address.addressType == '1'
                            ? 'Office'
                            : 'Other',
                    borderRadius: 0.0,
                    textColor: AppColors.textColor2,
                    fontSize: 12,
                    fontweight: FontWeight.w500,
                    borderColor: AppColors.addressTypeText,
                    buttonColor: AppColors.addressTypeBox,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.address.name ?? '',
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
                  widget.address.mobile ?? '',
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
                      '${widget.address.city ?? ''}\n${widget.address.state ?? ''}\n${widget.address.country!.name ?? ''}\n${widget.address.zipcode ?? ''}',
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
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      elevation: 0.0,
      expandedHeaderPadding: EdgeInsets.zero,
      disabledColor: AppColors.textColor2,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          addressTileOpen = !isExpanded;
        });
      },
      animationDuration: const Duration(milliseconds: 700),
      children: [
        CustomExpansionPanel(
          headerBuilder: (context, isExpanded) {
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
            child: widget.items.isEmpty
                ? Center(
                    child: Text(
                      'No items available',
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                  )
                : Column(
                    children: [
                      CurvedBox(
                        borderRadius: 8.0,
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          itemCount: widget.items.length,
                          shrinkWrap: true,
                          itemBuilder: buildItemTile,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
          ),
          isExpanded: addressTileOpen,
        ),
      ],
    );
  }

  Widget buildItemTile(BuildContext context, int index) {
    final item = widget.items[index];
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
                containerImage: widget.items[index].image,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'No Name',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  item.manufacturer ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '₹ ${item.price ?? 0}',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.oldprice != null && item.oldprice != item.price)
                      const SizedBox(width: 10),
                    if (item.oldprice != null && item.oldprice != item.price)
                      Text(
                        '₹ ${item.oldprice!}',
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textColor2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.purchaseReward ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.orderDetailStatus,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                    subTitle: '₹ $grandTotal',
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
