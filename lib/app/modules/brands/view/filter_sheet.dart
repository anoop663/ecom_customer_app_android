import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/modules/brands/controllers/filter_controller.dart';
import 'package:ecommerce_app/app/widgets/app_filter_slider.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:ecommerce_app/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({super.key, this.onApply});
  final FilterController controller = Get.put(FilterController());

  final Function(Map<String, List<dynamic>>? filter)? onApply;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final currentTheme = Get.theme;
    return Container(
      color: currentTheme.primaryColor,
      child: Column(
        children: [
          Material(
            elevation: 0.2,
            color: currentTheme.primaryColor,
            child: ListTile(
              trailing: const Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.bottomSelectedColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              title: const Text(
                'Filters',
                style: TextStyle(
                  color: AppColors.textColor2,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                for (var element in controller.selectedFilters.entries) {
                  element.value.clear();
                }

                if (onApply != null) {
                  onApply!(controller.selectedFilters);
                }
              },
            ),
          ),
          Obx(
            () => controller.isLoading.isTrue
                ? const LoadingWidget()
                : Column(
                    children: [
                      Container(
                        color: currentTheme.primaryColor,
                        height: screenSize.height * 0.431,
                        child: Row(
                          children: [
                            Container(
                              width: screenSize.width * 0.4,
                              color: AppColors.filterCategoryColor,
                              child: ListView.builder(
                                itemCount: controller
                                    .fliterResponse.value!.filters!.length,
                                //   controller.response.value!.filters!.length,
                                itemBuilder: (context, state) {
                                  return Obx(
                                    () => InkWell(
                                      onTap: () {
                                        controller.currentSelected.value =
                                            controller
                                                .fliterResponse.value!.filters!
                                                .elementAt(state);
                                      },
                                      child: Container(
                                        color: controller.fliterResponse.value!
                                                    .filters!
                                                    .elementAt(state) ==
                                                controller.currentSelected.value
                                            ? AppColors.primary
                                            : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            controller
                                                .fliterResponse.value!.filters!
                                                .elementAt(state)
                                                .text!,
                                            style: const TextStyle(
                                              color:
                                                  AppColors.bottomSelectedColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Obx(() {
                              return controller.currentSelected.value == null
                                  ? const SizedBox()
                                  : (controller.currentSelected.value!.text! ==
                                          'Price')
                                      ? _buildPrice()
                                      : _buildCategoryFilter(
                                          screenSize,
                                          currentTheme,
                                        );
                            }),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.textColor1,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                spreadRadius: 2,
                                blurRadius: 9,
                                offset: Offset(
                                  0,
                                  -2,
                                ),
                              ),
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: CurvedButton(
                                onClick: () {
                                  for (var element
                                      in controller.selectedFilters.entries) {
                                    element.value.clear();
                                  }
                                  Get.back();
                                },
                                text: 'CLOSE',
                                textColor: AppColors.bottomNotSelectedColor,
                                // textColor: AppColors.textColor1,
                                // buttonColor: AppColors.bottomSelectedColor,
                                borderRadius: 0,
                              ),
                            ),
                            Expanded(
                              child: CurvedButton(
                                onClick: () {
                                  if (onApply != null) {
                                    onApply!(controller.selectedFilters);
                                  }
                                },
                                text: 'APPLY',
                                textColor: AppColors.textColor1,
                                buttonColor: AppColors.bottomSelectedColor,
                                borderRadius: 0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCategoryFilter(
    Size screenSize,
    ThemeData currentTheme,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.currentSelected.value!.values!.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    if (controller.currentSelected.value!.values![i].parentId !=
                            null &&
                        controller.currentSelected.value!.values![i].parentId !=
                            0)
                      const SizedBox()
                    else
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            controller.currentSelected.value!.values![i].name ??
                                '',
                            style: currentTheme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.textColor2,
                            ),
                          ),

                          /// checked if selected filters contain this value
                          value: controller.selectedFilters[
                                  controller.currentSelected.value!.type!]!
                              .contains(controller.currentSelected.value!
                                  .values![i].filterValueId!),

                          onChanged: (value) {
                            ///*selectedfilters is a map contains the same in controller
                            ///checks if selectedfilters contains this filter
                            if (controller.selectedFilters.containsKey(
                                controller.currentSelected.value!.type!)) {
                              ///checks if selectedfilters contains currently selected value
                              if (controller.selectedFilters[
                                      controller.currentSelected.value!.type!]!
                                  .contains(controller.currentSelected.value!
                                      .values![i].filterValueId!)) {
                                ///takes current filter values from selectedfilters as a temp value
                                var list = controller.selectedFilters[
                                    controller.currentSelected.value!.type!]!;

                                ///removes selected value from temp list
                                list.removeWhere((element) =>
                                    element ==
                                    controller.currentSelected.value!.values![i]
                                        .filterValueId!);

                                ///checks if this is a main category item
                                if (controller.currentSelected.value!.values![i]
                                            .parentId !=
                                        null &&
                                    controller.currentSelected.value!.values![i]
                                            .parentId ==
                                        0) {
                                  ///adds every subitem into the temp list
                                  controller.currentSelected.value!.values!
                                      .where((element) =>
                                          element.parentId.toString() ==
                                          controller.currentSelected.value!
                                              .values![i].filterValueId)
                                      .forEach((element) {
                                    list.remove(element.filterValueId!);
                                  });
                                }

                                ///updates selectedfilters value as temp list
                                controller.selectedFilters.update(
                                  controller.currentSelected.value!.type!,
                                  (value) => list,
                                );
                              } else {
                                ///takes current filter values from selectedfilters as a temp value
                                var list = controller.selectedFilters[
                                    controller.currentSelected.value!.type!];

                                ///adds the newly selected value into temp list
                                list!.add(controller.currentSelected.value!
                                    .values![i].filterValueId!);

                                ///checks if this is a main category item
                                if (controller.currentSelected.value!.values![i]
                                            .parentId !=
                                        null &&
                                    controller.currentSelected.value!.values![i]
                                            .parentId ==
                                        0) {
                                  ///iterate through every subitem into the temp list
                                  controller.currentSelected.value!.values!
                                      .where((element) =>
                                          element.parentId.toString() ==
                                          controller.currentSelected.value!
                                              .values![i].filterValueId)
                                      .forEach((element) {
                                    ///adds item's id into temp list if there is no item present
                                    list.addIf(
                                        !list.contains(element.filterValueId),
                                        element.filterValueId);
                                  });
                                }

                                ///updates selectedfilters value as temp list
                                controller.selectedFilters.update(
                                  controller.currentSelected.value!.type!,
                                  (value) => list,
                                );
                              }
                            }
                          },
                        ),
                      ),
                    if (controller.currentSelected.value!.values![i].parentId !=
                            null &&
                        controller.currentSelected.value!.values![i].parentId !=
                            0)
                      const SizedBox()
                    else
                      const Divider(
                        color: AppColors.filterCategoryColor,
                        thickness: 1.5,
                        indent: 10,
                        endIndent: 10,
                      ),

                    ///if there is parent id and that is not 0 means this is a child item
                    if (controller.currentSelected.value!.values![i].parentId !=
                            null &&
                        controller.currentSelected.value!.values![i].parentId ==
                            0)
                      Column(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(left: 5),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.currentSelected.value!.values!
                                .where((element) =>
                                    element.parentId.toString() ==
                                    controller.currentSelected.value!.values![i]
                                        .filterValueId)
                                .length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => CheckboxListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 35),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  title: Text(
                                    controller.currentSelected.value!.values!
                                            .where((element) =>
                                                element.parentId.toString() ==
                                                controller
                                                    .currentSelected
                                                    .value!
                                                    .values![i]
                                                    .filterValueId)
                                            .elementAt(index)
                                            .name ??
                                        '',
                                    style: currentTheme.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.textColor2,
                                      fontSize: 12,
                                    ),
                                  ),
                                  value: controller.selectedFilters[controller
                                          .currentSelected.value!.type!]!
                                      .contains(controller
                                          .currentSelected.value!.values!
                                          .where((element) =>
                                              element.parentId.toString() ==
                                              controller.currentSelected.value!
                                                  .values![i].filterValueId)
                                          .elementAt(index)
                                          .filterValueId!),
                                  onChanged: (value) {
                                    if (controller.selectedFilters.containsKey(
                                        controller
                                            .currentSelected.value!.type!)) {
                                      if (controller.selectedFilters[controller
                                              .currentSelected.value!.type!]!
                                          .contains(controller
                                              .currentSelected.value!.values!
                                              .where((element) =>
                                                  element.parentId.toString() ==
                                                  controller
                                                      .currentSelected
                                                      .value!
                                                      .values![i]
                                                      .filterValueId)
                                              .elementAt(index)
                                              .filterValueId!)) {
                                        var list = controller.selectedFilters[
                                            controller
                                                .currentSelected.value!.type!]!;
                                        list.removeWhere((element) =>
                                            element ==
                                            controller
                                                .currentSelected.value!.values!
                                                .where((element) =>
                                                    element.parentId
                                                        .toString() ==
                                                    controller
                                                        .currentSelected
                                                        .value!
                                                        .values![i]
                                                        .filterValueId)
                                                .elementAt(index)
                                                .filterValueId!);
                                        controller.selectedFilters.update(
                                          controller
                                              .currentSelected.value!.type!,
                                          (value) => list,
                                        );
                                      } else {
                                        var list = controller.selectedFilters[
                                            controller
                                                .currentSelected.value!.type!];
                                        list!.add(controller
                                            .currentSelected.value!.values!
                                            .where((element) =>
                                                element.parentId.toString() ==
                                                controller
                                                    .currentSelected
                                                    .value!
                                                    .values![i]
                                                    .filterValueId)
                                            .elementAt(index)
                                            .filterValueId!);
                                        controller.selectedFilters.update(
                                          controller
                                              .currentSelected.value!.type!,
                                          (value) => list,
                                        );
                                      }
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Select Price range',
            style: Get.theme.textTheme.bodySmall!.copyWith(
              color: AppColors.textColor2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AppFilterSlider(
            min: double.parse(controller.minPrice.value),
            max: double.parse(controller.maxPrice.value),
            onChanged: (rangeValues) {
              controller.selectedFilters.update(
                  'price',
                  (value) => [
                        rangeValues!.start.toString(),
                        rangeValues.end.toString()
                      ]);
            },
          ),
        ],
      ),
    ));
  }

  // ignore: unused_element

  // ignore: unused_element
}
