import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/modules/account/controller/account_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountView extends StatelessWidget {
  AccountView({super.key});

  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return Scaffold(
      appBar: CommonAppBar(toolBarTitle: 'Account'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.loading.isTrue
                ? const LoadingWidget()
                : Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'ORDERS, WISHLIST AND MORE',
                            style: currentTheme.textTheme.titleMedium!.copyWith(
                              color: AppColors.accountSubTitle,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      AccountListItem(
                        onTap: () => Get.toNamed(Routes.wishlist),
                        text: 'My WishList',
                        subTitle: 'Save & view your favourites here',
                        icon: IconStrings.likeOutlined,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      AccountListItem(
                        onTap: () => Get.toNamed(Routes.home),
                        text: 'My Orders',
                        subTitle: 'View, modify and track orders',
                        icon: IconStrings.orderIcon,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      AccountListItem(
                        onTap: () => Get.toNamed(Routes.address),
                        text: 'My Address',
                        subTitle: 'Edit, add or remove addresses',
                        icon: IconStrings.locationIcon,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      const SizedBox(height: 15),
                      AccountListItem(
                        onTap: () => Get.toNamed(Routes.address),
                        text: 'My Profile',
                        subTitle: 'View my profile related details',
                        icon: IconStrings.deleteAccount,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'SUPPORT',
                            style: currentTheme.textTheme.titleMedium!.copyWith(
                              color: AppColors.accountSubTitle,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SupportIcon(
                            onTap: () {},
                            icon: IconStrings.callIcon,
                            title: 'Call Us',
                          ),
                          SupportIcon(
                            onTap: () {},
                            icon: IconStrings.whatsappIcon,
                            title: 'Whatsapp',
                          ),
                          SupportIcon(
                            onTap: () {},
                            icon: IconStrings.mailOutlined,
                            title: 'Email Us',
                          ),
                          SupportIcon(
                            onTap: () {},
                            icon: IconStrings.deleteAccount,
                            title: 'Delete account',
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      AccountListItem(
                        onTap: () {},
                        text: 'Privacy Policy',
                        subTitle: '',
                        icon: IconStrings.privacyIcon,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      AccountListItem(
                        onTap: () {},
                        text: 'Return Refund Policy',
                        subTitle: '',
                        icon: IconStrings.returnPolicyIcon,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      AccountListItem(
                        onTap: () {},
                        text: 'Terms and Conditions',
                        subTitle: '',
                        icon: IconStrings.termsIcon,
                      ),
                      const Divider(color: AppColors.brandSeperator),
                      CurvedButton(
                        textColor: AppColors.textColor1,
                        buttonColor: AppColors.textColor2,
                        borderColor: AppColors.bottomSelectedColor,
                        fontweight: FontWeight.w500,
                        borderRadius: 4.0,
                        onClick: () {
                          controller.logoutFunction();
                        },
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 44,
                        isSelected: true,
                        text: 'LOGOUT',
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// Function to show the input popup
class SupportIcon extends StatelessWidget {
  const SupportIcon({
    super.key,
    required this.icon,
    this.title,
    this.backgroundColor,
    this.iconColor,
    this.radius,
    this.imageSize,
    this.fontColor,
    this.onTap,
  });
  final String icon;
  final String? title;
  final Color? backgroundColor, iconColor, fontColor;
  final double? radius, imageSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: radius ?? 26,
            backgroundColor: backgroundColor ?? AppColors.flashSaleBg,
            child: icon.contains('asset')
                ? Image.asset(
                    icon,
                    height: imageSize ?? 22,
                    color: iconColor,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar();
                    },
                  )
                : Image.network(
                    ApiConfig.contentImageUrl + icon,
                    height: imageSize ?? 22,
                    color: iconColor,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar();
                    },
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (title != null)
            if (title != '')
              Text(
                title!,
                style: Get.theme.textTheme.bodySmall!.copyWith(
                  color: fontColor ?? AppColors.textColor2,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
        ],
      ),
    );
  }
}

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    super.key,
    this.icon,
    this.text,
    this.subTitle,
    this.onTap,
  });

  final String? text, subTitle, icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.bottomSelectedColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            icon ?? IconStrings.likeOutlined,
            color: AppColors.primary,
          ),
        ),
      ),
      title: Text(
        text ?? '',
        style: currentTheme.textTheme.titleMedium!.copyWith(
          color: AppColors.textColor2,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      subtitle: subTitle == ''
          ? null
          : Text(
              subTitle ?? '',
              style: currentTheme.textTheme.titleMedium!.copyWith(
                color: AppColors.accountSubTitle,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
      trailing: Image.asset(
        IconStrings.rightArrow,
        color: AppColors.accountIconColor,
        height: 17,
      ),
    );
  }
}
