import 'package:ecommerce_app/app/controllers/base_controller.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/account/view/account_view.dart';
import 'package:ecommerce_app/app/modules/best_items/view/best_items_view.dart';
import 'package:ecommerce_app/app/modules/brands/view/brand_view.dart';
import 'package:ecommerce_app/app/modules/categories/view/categories_view.dart';
import 'package:ecommerce_app/app/modules/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomBar extends StatelessWidget {
  final PageController _pageController = PageController();
  final NavigationController _navController = Get.put(NavigationController());
   //final String productSlug = 'No-slug';

  AppBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _navController.updateIndex(index);
        },
        children: [
          HomePage(),
          BrandPage(),
          BestItems(),
          CategoriesPage(),
          //CreateAddressView(),
          AccountView(),
          //MyAddressListView(),
        ],
      ),
      bottomNavigationBar: Obx(() => BottomAppBar(
            color: AppColors.primary,
            height: MediaQuery.of(context).size.height * 0.07,
            padding: EdgeInsets.zero,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: screenSize.width,
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomBarItem(
                      onTap: () {
                        _pageController.jumpToPage(0); // Jump to first page
                        _navController.updateIndex(0);
                      },
                      isSelected: _navController.selectedIndex.value == 0,
                      text: 'Home',
                      icon: IconStrings.homeIcon,
                    ),
                    BottomBarItem(
                      onTap: () {
                        _pageController.jumpToPage(1); // Jump to second page
                        _navController.updateIndex(1);
                      },
                      isSelected: _navController.selectedIndex.value == 1,
                      text: 'Brands',
                      icon: IconStrings.brandsIcon,
                    ),
                    BottomBarItem(
                      onTap: () {
                        _pageController.jumpToPage(2); // Jump to third page
                        _navController.updateIndex(2);
                      },
                      isSelected: _navController.selectedIndex.value == 2,
                      text: 'Best Items',
                      icon: IconStrings.bestItemIcon,
                    ),
                    BottomBarItem(
                      onTap: () {
                        _pageController.jumpToPage(3); // Jump to fourth page
                        _navController.updateIndex(3);
                      },
                      isSelected: _navController.selectedIndex.value == 3,
                      text: 'Categories',
                      icon: IconStrings.categoriesIcon,
                    ),
                    BottomBarItem(
                      onTap: () {
                        _pageController.jumpToPage(4); // Jump to fifth page
                        _navController.updateIndex(4);
                      },
                      isSelected: _navController.selectedIndex.value == 4,
                      text: 'Account',
                      icon: IconStrings.personIcon,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.text,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  final String icon, text;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            icon,
            height: 20,
            color: isSelected
                ? AppColors.bottomSelectedColor
                : AppColors.bottomNotSelectedColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? AppColors.bottomSelectedColor
                  : AppColors.bottomNotSelectedColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
