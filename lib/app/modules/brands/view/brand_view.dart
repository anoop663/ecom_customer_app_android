import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/shimmer_utils.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';

class BrandPage extends StatelessWidget {
  BrandPage({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var brandData = homeController.homeResponse.value;

    return Scaffold(
      appBar: CommonAppBar(showLogo: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Brands',
              style: TextStyle(
                color: AppColors.textColor2,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            if (brandData?.featuredbrands != null &&
                brandData!.featuredbrands!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: brandData.featuredbrands!.length,
                  itemBuilder: (context, index) {
                    final brand = brandData.featuredbrands![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.brandproducts,
                              arguments: {
                                'by': 'brand',
                                'value': brand.slug,
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                placeholder: (context, url) {
                                  return ShimmerUtil().container(
                                    height: MediaQuery.of(context).size.height * 0.6,
                                    width: double.infinity,
                                  );
                                },
                                imageUrl: brand.image!,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                errorWidget: (context, url, error) {
                                  return Image.asset(
                                    ImageStrings.noImage,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '0${index + 1}', // Display the number
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 1.0,
                                color: const Color.fromARGB(255, 202, 188, 188),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              brand.name!,
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    );
                  },
                ),
              )
            else
              const Center(
                child: Text('No brands available'),
              ),
          ],
        ),
      ),
    );
  }
}
