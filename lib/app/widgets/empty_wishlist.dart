import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              height: 200,
              width: 138,
              child: Image.asset(
                ImageStrings.emptyWishlist,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nothing in the wishlist',
              style: TextStyle(
                color: AppColors.textColor2,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CurvedButton(
                textColor: AppColors.textColor1,
                buttonColor: AppColors.bottomSelectedColor,
                borderColor: AppColors.bottomSelectedColor,
                fontweight: FontWeight.w500,
                borderRadius: 4.0,
                onClick: () {
                  Get.offAllNamed(Routes.bottombar);
                },
                width: double.infinity,
                height: 44,
                isSelected: true,
                text: 'CONTINUE SHOPPING',
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
