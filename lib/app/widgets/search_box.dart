import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:flutter/material.dart';



class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    this.searchController,
    this.hint,
    this.height,
    this.width,
    this.autoFocus,
  });

  final TextEditingController? searchController;
  final String? hint;
  final double? height, width;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      height: height ?? 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.searchBox,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Hero(
              tag: 'search',
              child: Image.asset(
                IconStrings.searchIcon,
                height: 16,
                color: AppColors.searchBoxIcon,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Center(
                child: TextField(
                  controller: searchController ?? TextEditingController(),
                  cursorColor: AppColors.searchBoxText,
                  textAlign: TextAlign.start,
                  enableSuggestions: true,
                  autofocus: autoFocus ?? true,
                  decoration: InputDecoration(
                    hintText: hint ?? 'Type Here to Search',
                    hintStyle: const TextStyle(
                      color: AppColors.searchBoxText,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.searchBoxText,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
