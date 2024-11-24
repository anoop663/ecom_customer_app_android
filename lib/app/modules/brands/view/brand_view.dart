import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                color: Colors.black,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: brand.image != null &&
                                        brand.image!.isNotEmpty
                                    ? NetworkImage(
                                        brand.image!,
                                      )
                                    : const AssetImage(
                                        'assets/images/no_image.png'),
                                fit: BoxFit.cover,
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
                                color: Colors.black,
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
                                color: Colors.black,
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
