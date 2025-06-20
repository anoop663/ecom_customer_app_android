import 'dart:convert';

import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/brands/model/brand_reponse_model.dart';
import 'package:ecommerce_app/app/modules/brands/model/filter_response_model.dart';
import 'package:ecommerce_app/app/modules/brands/model/newfilter_model.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';

class FilterController extends GetxController {
  final isLoading = false.obs;
  final fliterResponse = Rxn<FilterResponse>();
  final AuthService authService = AuthService();
  final StorageProvider storageProvider = StorageProvider();
  var brandproductResponse1 = Rxn<BrandReponseModel>();
  final filters = Rxn<Filters>();

  @override
  void onInit() {
    super.onInit();
    getFilters();
  }

  Map filterList = {};
  final categories = <FilterValue>[].obs;
  final sizes = <FilterValue>[].obs;
  final colors = <FilterValue>[].obs;
  final minPrice = ''.obs;
  final maxPrice = ''.obs;
  List discounts = [];

  final selectedFilters = <String, List<dynamic>>{}.obs;

  final currentSelected = Rxn<Filter>();

  void getFilters() async {
    var idToken = storageProvider.readLoginDetails();
    isLoading.value = true;

    HomeAuth homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );

    try {
      final response = await authService.filterData(homeAuth.toJson());

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == 1) {
          fliterResponse.value = FilterResponse.fromJson(responseData);

          if (fliterResponse.value!.filters!.isNotEmpty) {
            for (var element in fliterResponse.value!.filters!) {
              ///add every filter name to selected List

              selectedFilters.addAll({element.type!: []});

              ///only using price from here
              switch (element.type) {
                case 'category':
                  categories.addAll(element.values ?? []);
                  break;
                case 'size':
                  sizes.addAll(element.values ?? []);
                  break;
                case 'color':
                  colors.addAll(element.values ?? []);
                  break;
                case 'price':
                  for (int i = 0; i < element.values!.length; i++) {
                    if (element.values![i].filterValueId == 'min') {
                      minPrice.value = element.values![i].name!;
                    }
                    if (element.values![i].filterValueId == 'max') {
                      maxPrice.value = element.values![i].name!;
                    }
                  }

                  break;
                default:
              }
            }
          }
        } else {
          Get.snackbar(
              'Error', responseData['message'] ?? 'Failed to retrieve products',
              colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load products: $e',
          colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
    }
  }

  // void getBrandProducts2(String by, String value) async {
  //   var idToken = storageProvider.readLoginDetails();
  //   isLoading.value = true;

  //   BrandProductModel2 brandProductModel2 = BrandProductModel2(
  //     id: idToken.$1,
  //     token: idToken.$2,
  //     by: by,
  //     value: value,
  //     filters: filters.value,
  //   );

  //   try {
  //     final response =
  //         await authService.brandbaseProduct(brandProductModel2.toJson());

  //     isLoading.value = false;

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);

  //       if (responseData['success'] == 1) {
  //         brandproductResponse1.value =
  //             BrandReponseModel.fromJson(responseData);
  //         //Get.snackbar('Success', 'Product Listed',
  //         //    colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
  //       } else {
  //         Get.snackbar(
  //             'Error', responseData['message'] ?? 'Failed to retrieve products',
  //             colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Server error: ${response.statusCode}',
  //           colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', 'Failed to load products: $e',
  //         colorText: AppColors.primary, backgroundColor: AppColors.textColor2);
  //   }
  // }
  final sortItems = [
    'Price: Low to High',
    'Price: High to Low',
    'Name: A to Z',
    'Name: Z to A',
    'Top Rated',
    'Low Rated',
    'Popular'
  ];
}
