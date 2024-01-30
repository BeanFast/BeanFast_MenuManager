import 'package:beanfast_menumanager/controllers/kitchen_controller.dart';
import 'package:beanfast_menumanager/controllers/menu_controller.dart';
import 'package:beanfast_menumanager/controllers/school_controller.dart';
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
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<KitchenController>(() => KitchenController());
    Get.lazyPut<SchoolController>(() => SchoolController());
  }
}
class HomeBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
class FoodBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FoodController>(() => FoodController());
  }
}