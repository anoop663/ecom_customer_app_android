import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/base_controller.dart';
import '../../../core/values/colors.dart';
import '../../../widgets/curve_button.dart';
import '../../address_manage/model/address_response_model.dart';

class AddressExpantionTile extends StatelessWidget {
  final Address address;
  const AddressExpantionTile({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.textColor1,
      child: ExpansionTile(
        title: Row(
          children: [
            CurvedButton(
              height: 24,
              width: 55,
              text: address.addressType == '0'
                  ? 'Home'
                  : address.addressType == '1'
                      ? 'Office'
                      : 'Other',
              borderRadius: 0.0,
              textColor: AppColors.textColor2,
              fontSize: 12,
              fontweight: FontWeight.w500,
              borderColor: AppColors.addressTypeText,
              buttonColor: AppColors.addressTypeBox,
            ),
            const SizedBox(width: 10),
            Text(
              address.name ?? '',
              style: Get.theme.textTheme.bodyMedium!.copyWith(
                color: AppColors.removeButton,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  address.mobile ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                dense: true,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '${address.city ?? ''}\n${address.state ?? ''}\n${address.country?.name ?? ''}\n${address.zipcode ?? ''}',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                // trailing: InkWell(
                //   onTap: () async {
                //     await Future.delayed(const Duration(milliseconds: 10));
                //     await Get.toNamed(Routes.home,
                //         arguments: {'address': address});
                //   },
                //   child: Text(
                //     'Edit',
                //     style: Get.theme.textTheme.bodyMedium!.copyWith(
                //       color: AppColors.bottomSelectedColor,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                isThreeLine: true,
              ),
              InkWell(
                onTap: () {
                  if (!Get.isRegistered<BaseController>()) {
                    Get.put(BaseController());
                    Get.put(BaseController())
                        .openAddressListBottomSheet(context: context);
                  } else {
                    Get.put(BaseController())
                        .openAddressListBottomSheet(context: context);
                  }
                },
                child: Text(
                  'CHANGE ADDRESS',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.bottomSelectedColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
