import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductBottomIcon extends StatelessWidget {
  const ProductBottomIcon({
    super.key,
    required this.icon,
    required this.title,
    //required this.subTitle,
    required this.onTap,
    // this.isSelected = false,
  });
  final String? icon, title;
  // subTitle;
  final Function()? onTap;
  //final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 4,
            
          ),
          const SizedBox(
            width: 10,
          ),
          if (icon != null)
            Image.asset(
              icon!,
              height: 20,
            ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Text(
                  title ?? '',
                  style: currentTheme.textTheme.titleMedium!.copyWith(
                    color: AppColors.textColor2,
                  ),
                ),
              const SizedBox(
                height: 2,
              ),
              
                   
                    
                  
            ],
          )
        ],
      ),
    );
  }
}
