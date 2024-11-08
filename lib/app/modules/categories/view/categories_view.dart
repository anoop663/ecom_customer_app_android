import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                color: Colors.black,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(category.category!.image!),
                                fit: BoxFit.cover,
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