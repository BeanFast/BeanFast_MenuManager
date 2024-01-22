import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isNavigationRailSelected = true.obs;

  void toggleNavigation() {
    isNavigationRailSelected.toggle();
  }
}