import 'package:get/get.dart';

import '/services/api_service.dart';
import '/controllers/auth_controller.dart';
import '/controllers/home_controller.dart';
import '/controllers/food_controller.dart';
import '/controllers/menu_controller.dart';
import '/controllers/school_controller.dart';
import '/controllers/menu_detail_controller.dart';
import 'controllers/session_controller.dart';

class AuthBindingController extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FoodController>(() => FoodController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<SchoolController>(() => SchoolController());
    // Get.lazyPut<OrderController>(() => OrderController());
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

class MenuBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}

class MenuDetailBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuDetailController>(() => MenuDetailController());
  }
}

class ManageMenuViewBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(() => SessionController());
  }
}
