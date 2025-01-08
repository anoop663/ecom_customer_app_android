import 'package:flutter/material.dart';
import 'package:soulstyle/app/core/values/colors.dart';

class CurvedBox extends StatelessWidget {
  const CurvedBox({
    super.key,
    this.height,
    this.minHeight,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.boxColor,
    this.child,
  });
  final double? height, width, borderRadius, minHeight;
  final Color? borderColor, boxColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.cartItemBorder,
        ),
        color: boxColor ?? AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
      ),
      child: child,
    );
  }
}
