import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/modules/brands/controllers/brand_product_controller.dart';
import 'package:ecommerce_app/app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandProducts extends StatelessWidget {
  BrandProducts({super.key});
  final BrandProductController brandProductController =
      Get.put(BrandProductController());

  @override
  Widget build(BuildContext context) {
    // Retrieve passed arguments
    final String by = Get.arguments['by'];
    final String value = Get.arguments['value'];

    // Fetch products based on 'by' and 'value'
    brandProductController.getBrandProducts1(by, value);

    return Scaffold(
      appBar: CommonAppBar(
        showLogo: false,
        toolBarTitle: 'Products',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          var productsData = brandProductController.brandproductResponse.value;

          if (brandProductController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (productsData?.products != null &&
                  productsData!.products.returnData.data.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: productsData.products.returnData.data.length,
                    itemBuilder: (context, index) {
                      final product =
                          productsData.products.returnData.data[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height *
                                0.3, // Adjusted height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    ApiConfig.productImageUrl + product.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '₹ ${product.price}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Text('No Products available'),
                ),
            ],
          );
        }),
      ),
    );
  }
}
