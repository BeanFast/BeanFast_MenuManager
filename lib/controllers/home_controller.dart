import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contrains/contrain.dart';
import '/utils/menu_item.dart';
import '/utils/logger.dart';
import '/views/pages/category_page.dart';
import '/views/pages/delivery_page.dart';
import '/views/pages/gift_page.dart';
import '/views/pages/food_page.dart';
import '/views/pages/dashboard_page.dart';
import '/views/pages/kitchen_page.dart';
import '/views/pages/school_page.dart';
import '/views/pages/menu_page.dart';
import '/views/pages/order_page.dart';

Map<int, Widget> list = {};

class HomeController extends GetxController {
  RxBool isNavigationRailSelected = true.obs;
  // index of menuItem
  Rx<Widget> selectedContent = Rx<Widget>(const OrderView());

  // menu mặc định
  List<MenuItem> menuItems = [
    const MenuItem(title: 'Dashboard', icon: Icons.space_dashboard_outlined),
    const MenuItem(title: 'Thức ăn', icon: Icons.fastfood_outlined),
    const MenuItem(title: 'Thực đơn', icon: Icons.menu_outlined),
    const MenuItem(title: 'Đơn hàng', icon: Icons.assignment_outlined),
    const MenuItem(title: 'Đơn quà', icon: Icons.assignment_turned_in_outlined),
    const MenuItem(title: 'Giao hàng', icon: Icons.local_shipping_outlined),
    const MenuItem(title: 'Bếp', icon: Icons.kitchen_outlined),
    const MenuItem(title: 'Trường', icon: Icons.school_outlined),
    const MenuItem(title: 'Quà', icon: Icons.card_giftcard_outlined),
    const MenuItem(title: 'Loại', icon: Icons.category_outlined),
    const MenuItem(title: 'Cài đặt', icon: Icons.settings_outlined),
  ];

  // index là vị trí của menuItems
  Widget setSelectedContent(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return const FoodView();
      case 2:
        return const MenuView();
      case 3:
        return const OrderView();
      case 4:
        return colorGreen();
      case 5:
        return const DeliveryView();
      case 6:
        return const KitchenView();
      case 7:
        return const SchoolView();
      case 8:
        return const GiftView();
      case 9:
        return const CategoryView();
      case 10:
        return colorGreen();
      default:
        return colorGreen();
    }
  }

  void changePage(int index) {
    selectedMenuIndex.value = index;
    selectedContent.value = setSelectedContent(index);
  }

  void toggleNavigation() {
    isNavigationRailSelected.toggle();
  }
}

Widget colorBlue() {
  logger.i('ColorBlue');
  return Scaffold(
    body: Container(
      color: Colors.blue,
    ),
  );
}

Widget colorYellow() {
  logger.i('ColorYellow');
  return Scaffold(
    body: Container(
      color: Colors.yellow,
    ),
  );
}

Widget colorGreen() {
  logger.i('ColorGreen');
  return Scaffold(
    body: Container(
      color: Colors.green,
    ),
  );
}
