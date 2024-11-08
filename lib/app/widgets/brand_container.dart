import 'package:ecommerce_app/app/modules/home/models/home_response.dart';
import 'package:flutter/material.dart';


class BrandContainer extends StatelessWidget {
  const BrandContainer({
    super.key,
    required this.brand,
    this.height,
    this.width,
    this.brandImageWidth,
    this.extraChild,
  });

  final double? height, width;
  final Brand brand;
  final double? brandImageWidth;
  final Widget? extraChild;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

        await Future.delayed(const Duration(milliseconds: 10));
       // Get.to();
      },
      child: Stack(
        children: [
         
        ],
      ),
    );
  }
}
