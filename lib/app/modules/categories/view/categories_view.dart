import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/shimmer_utils.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var categoriesData = homeController.homeResponse.value;

    return Scaffold(
      appBar: CommonAppBar(showLogo: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                color: AppColors.textColor2,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            if (categoriesData?.categories != null && categoriesData!.categories!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: categoriesData.categories!.length,
                  itemBuilder: (context, index) {
                    final category = categoriesData.categories![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.brandproducts,
                              arguments: {
                                'by': 'category',
                                'value': category.category!.slug,
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 2.0),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                placeholder: (context, url) {
                                  return ShimmerUtil()
                                      .container(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: double.infinity,
                                  );
                                },
                                imageUrl:
                                category.category!.image!,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                errorWidget:
                                    (context, url, error) {
                                  return Image.asset(
                                    ImageStrings.noImage,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        //const SizedBox(height: 1),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              )
            else
              const Center(
                child: Text('No categories available'),
              ),
          ],
        ),
      ),
    );
  }
}