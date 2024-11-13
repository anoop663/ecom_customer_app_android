import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/app/core/utils/app_connectivity.dart';
import 'package:ecommerce_app/app/modules/address_manage/model/address_response_model.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}

class BaseController extends GetxController {
  final source = {ConnectivityResult.none: false}.obs;
  final AppConnectivity _connectivity = AppConnectivity.instance;
  final selectedBottom = 0.obs;
  final isBottomNeeded = false.obs;
  final cartCount = 0.obs;
  final wishListCount = 0.obs;

//
  final addressLoading = false.obs;
  final addressListResponse = Rxn<AddressListResponse>();

  final sortItems = [
    'Price: Low to High',
    'Price: High to Low',
    'Name: A to Z',
    'Name: Z to A',
    'Top Rated',
    'Low Rated',
    'Popular'
  ];

  @override
  void onInit() {
    super.onInit();
    _connectivity.initialise();
    _connectivity.myStream.listen((source1) {
      source(source1);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
