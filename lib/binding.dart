import 'package:beanfast_menumanager/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

class AuthBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
class HomeBindingController extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}