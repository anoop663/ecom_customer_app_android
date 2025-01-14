import 'package:ecommerce_app/app/data/storage_provider.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  final isLoading = false.obs;

  final StorageProvider _storageProvider = StorageProvider();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 3));
    try {
      // Check if it's the first time user
      //int? ft = await _storageProvider.readFirstTime();
      checkLogin();
        } catch (e) {
      Get.offAllNamed(Routes.signin);
      return;
    } finally {
      isLoading.value = false;
    }
  }

  void checkLogin() {
    final (String? id, String? token) = _storageProvider.readLoginDetails();
    
    if (id != null && id.isNotEmpty && token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.bottombar);
    } else {
      Get.offAllNamed(Routes.signin);
    }
  }
} 