import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/modules/address_manage/controller/createaddress_controller.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateAddressView extends StatelessWidget {
  CreateAddressView({super.key});
  final TextEditingController addressTypeController = TextEditingController();

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
                    SizedBox(height: 30),
                    PhoneNumberField(
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 30),
                    AddressTextField(
                      hint: 'Flat No/Building No, Street Name',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 30),
                    AddressTextField(
                      hint: 'City',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 30),
                    AddressTextField(
                      hint: 'State',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 30),
                    AddressTextField(
                      hint: 'Post Code',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 30),
                    AddressTextField(
                      hint: 'Country',
                      controller: TextEditingController(text: 'India'),
                      readOnly: true,
                    ),
                    SizedBox(height: 30),

                    // Title and Buttons
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Save address as',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor2,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ///////////////////////
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child:  ElevatedButton(
                                  onPressed: () {
                                    controller.addressTypeValue.value = 0;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.addressTypeValue.value == 0
                                            ? AppColors.bottomSelectedColor
                                            : AppColors.bottomNotSelectedColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            8), 
                                            minimumSize: Size(1, 10),// Adjust padding if needed
                                  ),
                                  child: Text(
                                    'HOME',
                                    style: TextStyle(
                                      fontSize:
                                          14, // Set the desired font size here
                                      color:
                                          controller.addressTypeValue.value == 1
                                              ? AppColors.textColor2
                                              : AppColors.textColor1,
                                    ),
                                  ),
                                ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child:  ElevatedButton(
                                  onPressed: () {
                                    controller.addressTypeValue.value = 1;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.addressTypeValue.value == 1
                                            ? AppColors.bottomSelectedColor
                                            : AppColors.bottomNotSelectedColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            8),
                                            minimumSize: Size(5, 10), // Adjust padding if needed
                                  ),
                                  child: Text(
                                    'OFFICE',
                                    style: TextStyle(
                                      
                                      fontSize:
                                          14, // Set the desired font size here
                                      color:
                                          controller.addressTypeValue.value == 1
                                              ? AppColors.textColor2
                                              : AppColors.textColor1,
                                    ),
                                  ),
                                ),
                              ),
                            
                            SizedBox(width: 5),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.addressTypeValue.value = 2;
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.addressTypeValue.value == 2
                                            ? AppColors.bottomSelectedColor
                                            : AppColors.bottomNotSelectedColor,
                                    shape: RoundedRectangleBorder(
                                      
                                      borderRadius: BorderRadius.circular(20),
                                      
                                    ),
                                    minimumSize: Size(10, 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            8), // Adjust padding if needed
                                  ),
                                  child: Text(
                                    'OTHER',
                                    style: TextStyle(
                                      fontSize:
                                          14, // Set the desired font size here
                                      color:
                                          controller.addressTypeValue.value == 1
                                              ? AppColors.textColor2
                                              : AppColors.textColor1,
                                    ),
                                  ),
                                ),
                              ),
                            
                          ],
                        ),
                        ),
                    SizedBox(height: 30),
                    CurvedButton(
                      onClick: () {
                        controller.address();
                      },
                      borderRadius: 0,
                      width: MediaQuery.of(context).size.width,
                      textColor: AppColors.primary,
                      buttonColor: AppColors.bottomSelectedColor,
                      text: 'SAVE ADDRESS',
                    ),
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
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.addressTextFieldBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            color: AppColors
                .addressTextFieldBorder2, // Optional: set background color
            child: const Text(
              '+91',
              style: TextStyle(
                color: AppColors.textColor2,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const VerticalDivider(
            color: AppColors.addressTextFieldBorder,
            thickness: 1,
          ),
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
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
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
