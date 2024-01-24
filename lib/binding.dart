import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/food_controller.dart';
import 'controllers/home_controller.dart';

class AuthBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FoodController>(() => FoodController());
  }
}
class HomeBindingController extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
  }
}