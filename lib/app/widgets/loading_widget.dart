import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          AnimationStrings.loadingAnimation,
          alignment: Alignment.center,
          height: height ?? 150,
          width: width ?? 150,
        ),
      ],
    );
  }
}
