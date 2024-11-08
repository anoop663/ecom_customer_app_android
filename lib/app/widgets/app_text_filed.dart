import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscure = false,
    this.onSuffixTap,
    this.cursorColor,
    this.maxLength,
    this.focusNode,
    this.inputType,
  });

  final String? hint;
  final TextEditingController? controller;
  final String? prefixIcon, suffixIcon;
  final bool isObscure;
  final Function()? onSuffixTap;
  final Color? cursorColor;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      maxLength: maxLength,
      keyboardType: inputType,
      controller: controller ?? TextEditingController(),
      obscureText: isObscure,
      cursorColor: cursorColor ?? AppColors.primary,
      decoration: InputDecoration(
        counter: const SizedBox(),
        hintText: hint,
        hintStyle:
            WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
          final Color color = states.contains(WidgetState.focused)
              ? AppColors.textColor1
              : AppColors.noFocusColor;
          return TextStyle(color: color);
        }),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: prefixIcon != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    prefixIcon!,
                    height: 22,
                  ),
                ],
              )
            : null,
        suffixIcon: suffixIcon != null
            ? InkWell(
                onTap: onSuffixTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      suffixIcon!,
                      height: 22,
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
