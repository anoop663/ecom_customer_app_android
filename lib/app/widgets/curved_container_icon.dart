import 'package:ecommerce_app/app/core/extensions/custom_page_scroll.dart';
import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';

class CurvedContainerWithImage extends StatelessWidget {
  const CurvedContainerWithImage({
    super.key,
    this.containerImage,
    this.height,
    this.width,
    this.isSoldOut = false,
  });

  final String? containerImage;
  final double? height, width;
  final bool isSoldOut;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: height ?? screenSize.height * 0.2,
        width: width ?? screenSize.width * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            PageView.builder(
              physics: const CustomPageViewScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                final imageUrl = '${ApiConfig.productImageUrl}$containerImage';

                // ignore: unnecessary_null_comparison
                return imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImageStrings.noImage,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        ImageStrings.noImage,
                        fit: BoxFit.cover,
                      );
              },
            ),
            if (isSoldOut)
              Container(
                color: AppColors.noFocusColor,
                child: Align(
                  alignment: const Alignment(0, 0.8),
                  child: CurvedButton(
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.21,
                    borderRadius: 0,
                    textColor: AppColors.primary,
                    buttonColor: AppColors.textColor2,
                    borderColor: AppColors.textColor2,
                    text: 'Sold Out',
                    fontSize: 14,
                    fontweight: FontWeight.w500,
                    isSelected: true,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
