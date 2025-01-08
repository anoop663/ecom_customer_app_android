
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulstyle/app/core/values/api_configs.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/core/values/strings.dart';

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
