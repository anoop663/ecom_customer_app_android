import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../widgets/add_radiobox.dart';
import '../../cart/model/cart_response_model.dart';

class CheckboxExpansionTile extends StatelessWidget {
  const CheckboxExpansionTile(
      {super.key,
      required this.modes,
      required this.onChanged,
      this.selectedMode});
  final List<PaymentMode>? modes;
  final Function(int value) onChanged;
  final int? selectedMode;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.textColor1,
      child: ExpansionTile(
        title: Text(
          'Select a Payment Method',
          style: Get.theme.textTheme.bodyMedium!.copyWith(
            color: AppColors.removeButton,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                modes == null
                    ? const AppRadioTextButton(
                        text: 'Cash On Delivery',
                        isSelected: true,
                        selectedTextColor: AppColors.bottomSelectedColor,
                        unSelectedTextColor: AppColors.bottomNotSelectedColor,
                        unSelectedButtonColor: AppColors.bottomNotSelectedColor,
                        selectedButtonColor: AppColors.bottomSelectedColor,
                      )
                    : ListView.separated(
                        itemCount: modes!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AppRadioTextButton(
                            onTap: () {
                              onChanged(modes![index].id!);
                            },
                            text: modes![index].mode!,
                            isSelected: selectedMode == modes![index].id,
                            selectedTextColor: AppColors.bottomSelectedColor,
                            unSelectedTextColor:
                                AppColors.bottomNotSelectedColor,
                            unSelectedButtonColor:
                                AppColors.bottomNotSelectedColor,
                            selectedButtonColor: AppColors.bottomSelectedColor,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 30,
                            indent: 10,
                            endIndent: 10,
                          );
                        },
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
