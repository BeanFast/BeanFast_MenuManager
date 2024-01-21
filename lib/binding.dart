import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

class AuthBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
class HomeBindingController extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthController>(() => AuthController());
  }
}