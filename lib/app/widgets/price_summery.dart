import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceSummaryItem extends StatelessWidget {
  const PriceSummaryItem({
    super.key,
    required this.title,
    required this.subTitle,
    this.fontweight,
    this.fontsize,
  });
  final String title, subTitle;
  final FontWeight? fontweight;
  final double? fontsize;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: currentTheme.textTheme.bodyMedium!.copyWith(
            color: AppColors.removeButton,
            fontWeight: fontweight,
            fontSize: fontsize,
          ),
        ),
        Text(
          subTitle.toLowerCase().contains('free') ? subTitle : subTitle,
          style: currentTheme.textTheme.bodyMedium!.copyWith(
            fontWeight: fontweight,
            fontSize: fontsize,
            color: subTitle.toLowerCase().contains('free')
                ? AppColors.offerTextBg
                : AppColors.removeButton,
          ),
        ),
      ],
    );
  }
}
