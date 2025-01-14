
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../values/colors.dart';

class ShimmerUtil {
  container({double? height, double? width,double? curve,EdgeInsetsGeometry? margin}) {
    return Shimmer.fromColors(
      // baseColor:const AppColors.shimmerBaseColor,
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.textColor1,
        child: Container(
          margin: margin??EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius:curve!=null? BorderRadius.circular(curve):null,
            color: AppColors.textColor1,
          ),
          height: height??50,
          width: width??50,
        ));
  }

  circle({double? radius}) {
    return Shimmer.fromColors(
        baseColor:const Color(0xFFF4F4F4),
        highlightColor: AppColors.textColor1,
        child: CircleAvatar(
          radius: radius,
        ));
  }
}

