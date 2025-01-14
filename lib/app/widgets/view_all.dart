import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class ViewAllText extends StatelessWidget {
  const ViewAllText({
    super.key,
    this.onTap,
    this.fontSize,
    this.text,
    this.textDecoration,
  });
  final Function()? onTap;
  final double? fontSize;
  final String? text;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;

    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: text,
          style: currentTheme.textTheme.bodySmall!.copyWith(
            color: AppColors.viewAll,
            fontSize: fontSize ?? 12,
            decoration: textDecoration ?? TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
