import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/core/values/strings.dart';
import 'package:soulstyle/app/modules/my_profile/controller/profile_controller.dart';
import 'package:soulstyle/app/widgets/app_bar.dart';
import 'package:soulstyle/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      appBar: CommonAppBar(
        toolBarTitle: 'MY PROFILE',
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Profile picture
              Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(115),
                        border:
                            Border.all(color: AppColors.searchBox, width: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(115),
                        child: Obx(
                          () => controller.profileResponse.value == null
                              ? const SizedBox()
                              : Image.asset(
                                  controller.profileResponse.value!.customerData!.gender ==
                                          'male'
                                      ? IconStrings.profilePicMale
                                      : IconStrings.profilePicFemale,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Form fields and save button
              Obx(
                () => controller.isLoading.isTrue
                    ? const LoadingWidget()
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileTextField(
                                controller: controller.nameController,
                                hint: 'Full Name',
                              ),
                              const SizedBox(height: 20),
                              ProfileTextField(
                                controller: controller.mailController,
                                hint: 'Email ID',
                                readOnly: true,
                              ),
                              const SizedBox(height: 20),
                              ProfileTextField(
                                controller: controller.phoneController,
                                hint: 'Phone Number',
                                readOnly: true,
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable TextField widget
class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    this.hint,
    this.controller,
    this.readOnly = false,
  });

  final String? hint;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldLabel),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldLabel),
        ),
        labelText: hint,
        labelStyle: Get.theme.textTheme.bodyMedium!.copyWith(
          color: AppColors.textFieldLabel,
        ),
        contentPadding: const EdgeInsets.all(2),
      ),
      style: Get.theme.textTheme.labelMedium!
          .copyWith(color: readOnly ? AppColors.textFieldLabel : null),
    );
  }
}
