import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/core/values/strings.dart';
import 'package:soulstyle/app/modules/search/controller/search_controller.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:soulstyle/app/widgets/search_box.dart';
import 'package:soulstyle/app/widgets/section_titile.dart';

class SearchView extends StatelessWidget {
  final SearchController1 controller = Get.put(SearchController1());

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? searchDelay;

    controller.searchController.addListener(() {
      final query = controller.searchController.text.trim();

      // Trigger search only if the query is valid and different
      if (query.length >= 2) {
        if (searchDelay?.isActive ?? false) searchDelay?.cancel();
        searchDelay = Timer(const Duration(seconds: 1), () {
          controller.searchData2(query);
        });
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(
        searchController: controller.searchController,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popular Searches Section
            Obx(() {
              if (controller.popularLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.popularResponse.value == null ||
                  controller.popularResponse.value!.popularSearch.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 9.0,
                      runSpacing: 5.0,
                      children: [
                        for (final item in controller.list)
                          SearchChip(
                            text: item,
                            onTap: () {
                              controller.searchController.text = item;
                            },
                          ),
                      ],
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Popular Searches'),
                  const SizedBox(height: 10),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 9.0,
                    runSpacing: 5.0,
                    children: [
                      for (int index = 0;
                          index <
                              controller
                                  .popularResponse.value!.popularSearch.length;
                          index++)
                        SearchChip(
                          text: controller
                              .popularResponse.value!.popularSearch[index],
                          onTap: () {
                            controller.searchController.text = controller
                                .popularResponse.value!.popularSearch[index];
                          },
                        ),
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),

            // Search Results Section
            Expanded(
              child: Obx(() {
                if (controller.loading.isTrue) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.sresponse.value == null ||
                    controller.sresponse.value!.products.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found for your search.',
                      style: TextStyle(
                        color: AppColors.textColor2,
                        fontSize: 14,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.sresponse.value!.products.length,
                  itemBuilder: (context, j) {
                    final product = controller.sresponse.value!.products[j];
                    return ListTile(
                      onTap: () {
                        Get.toNamed(
                          Routes.productdetails,
                          arguments: {
                            'product-slug':
                                controller.sresponse.value!.products[j].slug
                          },
                        );
                      },
                      leading: Image.asset(
                        IconStrings.searchIcon,
                        height: 20,
                        color: AppColors.searchBoxIcon,
                      ),
                      title: Text(
                        product.name,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.textColor2,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchChip extends StatelessWidget {
  const SearchChip({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Get.theme;
    return InkWell(
      onTap: onTap,
      child: Chip(
        backgroundColor: AppColors.transparent,
        side: const BorderSide(
          color: AppColors.searchBoxIcon,
        ),
        label: Text(
          text,
          style: currentTheme.textTheme.bodySmall!.copyWith(
            color: AppColors.textColor2,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.searchController,
  });
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Hero(
        tag: 'logo',
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              //Get.toNamed(
              //  Routes.bottombar,
              //);
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          ),
        ),
      ),
      foregroundColor: AppColors.textColor2,
      title: SearchBox(searchController: searchController),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
