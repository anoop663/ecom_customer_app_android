import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/routes.dart';

class StorageProvider {
  GetStorage storage = GetStorage();
  storeLoginDetails(String? id, String? token, {bool isGuest = false}) {
    storage.write('id', id ?? '');
    storage.write('token', token ?? '');
  }

  storeFirstTime(int? i) {
    storage.write('firstTime', i);
  }

  readFirstTime() {
    return storage.read('firstTime');
  }

  (String?, String?) readLoginDetails() {
    return (
      storage.read('id'),
      storage.read('token'),
    );
  }

  clearStored() {
  storage.erase();
   Get.toNamed(Routes.signin);
  }
}
