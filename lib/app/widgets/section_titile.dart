import 'package:ecommerce_app/app/widgets/view_all.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.showViewAll = false,
    this.viewAllAction,
  });
  final String title;
  final bool showViewAll;
  final Function()? viewAllAction;
  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: currentTheme.textTheme.displayMedium,
        ),
        if (showViewAll) const ViewAllText(),
      ],
    );
  }
}
