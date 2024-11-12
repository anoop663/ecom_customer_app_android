import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/modules/address_manage/controller/createaddress_controller.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateAddressView extends StatelessWidget {
  const CreateAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateAddressController controller =
        Get.put(CreateAddressController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        toolBarTitle: 'Add New Address',
      ),
      body: Obx(
        () => controller.isLoading.isTrue
            ? const Center(child: LoadingWidget())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AddressTextField(
                      hint: 'Full Name',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    PhoneNumberField(
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'Post Code',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'State',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'Flat No/Building No, Street Name',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'Area Locality',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'Land Mark (Optional)',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 20),
                    AddressTextField(
                      hint: 'Country',
                      controller: TextEditingController(text: 'India'),
                      readOnly: true,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.hint,
    this.controller,
    this.isPhone = false,
    this.onChanged,
    this.maxlength,
    this.keyboardType,
    this.readOnly = false,
  });

  final String hint;
  final TextEditingController? controller;
  final bool isPhone, readOnly;
  final Function(String? value)? onChanged;
  final String? maxlength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final int? maximumLength = int.tryParse(maxlength ?? '');

    return SizedBox(
      height: 50,
      child: TextField(
        readOnly: readOnly,
        maxLength: maximumLength,
        controller: controller ?? TextEditingController(),
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppColors.textColor2,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.addressTextFieldBorder,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.addressTextFieldBorder,
            ),
          ),
          labelText: hint,
          floatingLabelStyle: const TextStyle(
            color: AppColors.textColor2,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          filled: readOnly,
          fillColor: readOnly ? AppColors.addressTextFieldBorder2 : null,
          labelStyle: const TextStyle(
            color: AppColors.textColor2,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.addressTextFieldBorder),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              '+91',
              style: TextStyle(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller ?? TextEditingController(),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.addressTextFieldBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.addressTextFieldBorder,
                  ),
                ),
                labelText: 'Phone Number',
                counterText: '',
                labelStyle: TextStyle(
                  color: AppColors.textColor2,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
