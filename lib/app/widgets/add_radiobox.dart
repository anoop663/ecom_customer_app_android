import 'package:flutter/material.dart';
import 'package:soulstyle/app/core/values/colors.dart';


class AppRadioTextButton extends StatelessWidget {
  const AppRadioTextButton({
    super.key,
    this.isSelected = false,
    required this.text,
    this.onTap,
    this.selectedButtonColor,
    this.unSelectedButtonColor,
    this.selectedTextColor,
    this.unSelectedTextColor,
  });

  final bool isSelected;
  final String text;
  final Function()? onTap;
  final Color? selectedTextColor,
      unSelectedTextColor,
      selectedButtonColor,
      unSelectedButtonColor;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          AppRadioButton(
            isSelected: isSelected,
            selectedColor: selectedButtonColor,
            unSelectedColor: unSelectedButtonColor,
          ),
          const SizedBox(
            width: 10,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: currentTheme.textTheme.displaySmall!.copyWith(
              color: isSelected
                  ? selectedTextColor ?? AppColors.primary
                  : unSelectedTextColor ?? AppColors.noFocusColor,
            ),
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}

class AppRadioButton extends StatelessWidget {
  const AppRadioButton({
    super.key,
    this.isSelected = false,
    this.selectedColor,
    this.unSelectedColor,
  });
  final bool isSelected;
  final Color? selectedColor, unSelectedColor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      crossFadeState:
          isSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        height: screenSize.height * 0.03,
        width: screenSize.height * 0.03,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor ?? AppColors.primary,
            width: screenSize.height * 0.003,
          ),
          color: AppColors.transparent,
        ),
        padding: EdgeInsets.all(
          screenSize.height * 0.004,
        ),
        child: CircleAvatar(
          backgroundColor: selectedColor ?? AppColors.primary,
        ),
      ),
      secondChild: Container(
        height: screenSize.height * 0.03,
        width: screenSize.height * 0.03,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: unSelectedColor ?? AppColors.noFocusColor,
            width: screenSize.height * 0.003,
          ),
          color: AppColors.transparent,
        ),
      ),
    );
  }
}
