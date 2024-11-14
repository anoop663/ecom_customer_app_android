import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/cart/controller/cart_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    super.key,
    this.showLogo = false,
    this.showCart = true,
    this.showSearch = true,
    this.showWishList = true,
    this.toolBarTitle = '',
    this.color,
    this.toolBarTitleWidget,
  });
  
  final bool showLogo, showSearch, showWishList, showCart;
  final String toolBarTitle;
  final Color? color;
  final Widget? toolBarTitleWidget;

  // Using Get.find to retrieve the existing CartController instance
  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: 
        AppBar(
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: AppColors.textColor2,
          leading: !showLogo
              ? Hero(
                  tag: 'logo',
                  child: InkWell(
                    onTap: () {
                      if (!Navigator.canPop(context)) {
                        Get.offAllNamed(Routes.bottombar);
                      } else {
                        Get.back();
                      }
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                )
              : Hero(
                  tag: 'logo',
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(ImageStrings.logo),
                  ),
                ),
          title: toolBarTitleWidget ??
              Text(
                toolBarTitle,
                style: const TextStyle(
                  color: AppColors.textColor2,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
          centerTitle: false,
          actions: [
            SizedBox(
              width: screenSize.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (showSearch)
                    Hero(
                      tag: 'search',
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.signin),
                        child: Image.asset(
                          IconStrings.searchIcon,
                          height: 25,
                        ),
                      ),
                    ),
                  if (showWishList)
                    InkWell(
                      onTap: () => Get.toNamed(Routes.wishlist),
                      child: Image.asset(
                        IconStrings.likeOutlined,
                        height: 25,
                        width: 35,
                      ),
                    ),
                  if (showCart)
                    InkWell(
                      onTap: () => Get.toNamed(Routes.cart),
                      child: SizedBox(
                        height: 30,
                        width: 35,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                IconStrings.cartIcon,
                                height: 25,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Obx(() => CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColors.accessoriesColor5,
                                    child: Text(
                                      '${controller.cartResponse.value?.cartcount ?? 0}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textColor1,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
