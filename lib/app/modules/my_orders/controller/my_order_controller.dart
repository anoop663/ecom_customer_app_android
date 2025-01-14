import 'package:ecommerce_app/app/data/api_provider.dart';
import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/modules/my_orders/model/myorders_response.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/values/colors.dart';
import '../my_order_repo/my_order_repo.dart';

class MyOrdersController extends GetxController {
  final isLoading = false.obs;
  final response = Rxn<OrderListResponse>();
  final AuthService authService = AuthService();
  final MyOrderRepo myOrderRepo = MyOrderRepo();
  final StorageProvider storageProvider = StorageProvider();

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
  }

  void getMyOrders() async {
    final idToken = storageProvider.readLoginDetails();
    isLoading.value = true;
    final homeAuth = HomeAuth(
      id: idToken.$1,
      token: idToken.$2,
    );
    try {
      response.value = await myOrderRepo.myOrder(homeAuth.toJson());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load orders: $e',
        colorText: AppColors.textColor1,
        backgroundColor: AppColors.textColor2,
      );
    }
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
    return formattedDate;
  }

  // void getOrders() async {
  //   final idToken = storageProvider.readLoginDetails();
  //   isLoading.value = true;
  //   final homeAuth = HomeAuth(
  //     id: idToken.$1,
  //     token: idToken.$2,
  //   );
  //
  //   try {
  //     final apiResponse = await authService.brandbaseProduct(homeAuth.toJson());
  //     isLoading.value = false;
  //
  //     if (apiResponse.statusCode == 200) {
  //       final responseData = json.decode(apiResponse.body);
  //
  //       if (responseData['success'] == 1) {
  //         response.value = OrderListResponse.fromJson(responseData);
  //
  //       } else {
  //         Get.snackbar(
  //           'Error',
  //           responseData['message'] ?? 'Failed to retrieve orders',
  //           colorText: AppColors.textColor1,
  //           backgroundColor: AppColors.textColor2,
  //         );
  //       }
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Server error: ${apiResponse.statusCode}',
  //         colorText: AppColors.textColor1,
  //         backgroundColor: AppColors.textColor2,
  //       );
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar(
  //       'Error',
  //       'Failed to load orders: $e',
  //       colorText: AppColors.textColor1,
  //       backgroundColor: AppColors.textColor2,
  //     );
  //   }
  // }
}
