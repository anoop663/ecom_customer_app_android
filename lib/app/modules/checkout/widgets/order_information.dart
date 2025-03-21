import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../widgets/price_summery.dart';
import '../../cart/controller/cart_controller.dart';

class PriceExpandTile extends StatelessWidget {
  final String netTotal;
  final String wallet;
  final String tax;
  final String deliveryCharge;
  final String grandTotal;

   PriceExpandTile({
    super.key,
    required this.netTotal,
    required this.wallet,
    required this.tax,
    required this.deliveryCharge,
    required this.grandTotal,
  });
  final CartController cartController =
      Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cartResponse = cartController.cartResponse.value;

      if (cartResponse == null) {
        return Center(child: CircularProgressIndicator());
      }

      final netTotal = cartResponse.netTotal ?? '0';
      final grandTotal = cartResponse.grandTotal ?? '0';
      final tax = cartResponse.tax ?? '0';
      final deliveryCharge = cartResponse.deliveryCharge ?? 'FREE';
      return Card(
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Price Details',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.removeButton,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                '₹ $netTotal',
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  PriceSummaryItem(
                    title: 'Grand Total (Excl. VAT)',
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
          ],
        ),
      );


    });
  }
}
