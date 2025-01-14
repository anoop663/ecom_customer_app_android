import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class CurvedButton extends StatelessWidget {
  const CurvedButton(
      {super.key,
      this.text = '',
      this.height,
      this.width,
      this.isSelected = false,
      this.onClick,
      this.fontweight,
      this.fontSize,
      this.borderWidth,
      this.borderRadius,
      this.child,
      this.buttonColor = AppColors.textColor1,
      this.textColor = AppColors.textColor2,
      this.borderColor,
      this.isLoading = false});

  final String? text;
  final double? height, width;
  final bool isSelected;
  final Function()? onClick;
  final FontWeight? fontweight;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final Widget? child;
  final Color? buttonColor, textColor, borderColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: isLoading == false ? onClick : null,
      child: Container(
        height: height ?? screenSize.height * 0.06,
        width: width ?? screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: buttonColor ??
              (isSelected ? currentTheme.primaryColor : AppColors.transparent),
          border: Border.all(
            color: borderColor ?? currentTheme.primaryColor,
            width: borderWidth ?? 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              6,
            ),
          ),
        ),
        child: child ??
            (isLoading == false
                ? Center(
                    child: Text(
                      text ?? '',
                      style: currentTheme.textTheme.labelMedium!.copyWith(
                        color: textColor ??
                            (isSelected
                                ? AppColors.textColor2
                                : AppColors.textColor1),
                        fontWeight: fontweight ?? FontWeight.w400,
                        fontSize: fontSize ?? 16,
                      ),
                    ),
                  )
                : const Center(child: LoadingWidget())),
      ),
    );
  }
}
