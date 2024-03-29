import 'package:beanfast_menumanager/views/pages/tmp1.dart';
import 'package:beanfast_menumanager/views/pages/tmp2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/menu_item.dart';
import '/utils/logger.dart';
import '/views/pages/food_page.dart';
import '/views/pages/dashboard_page.dart';
import '/views/pages/kitchen_page.dart';
import '/views/pages/school_page.dart';
import '/views/pages/menu_page.dart';
import '/views/pages/order_page.dart';

Map<int, Widget> list = {};

class HomeController extends GetxController {
  RxBool isNavigationRailSelected = true.obs;
  RxInt selectedIndex = 0.obs; // index of menuItem
  Rx<Widget> selectedContent = initSelectedContent().obs;

  // menu mặc định
  List<MenuItem> menuItems = [
    const MenuItem(title: 'Dashboard', icon: Icons.space_dashboard),
    const MenuItem(title: 'Thức ăn', icon: Icons.fastfood),
    const MenuItem(title: 'Thực đơn', icon: Icons.menu),
    const MenuItem(title: 'Đơn hàng', icon: Icons.assignment),
    const MenuItem(title: 'Quà', icon: Icons.card_giftcard),
    const MenuItem(title: 'Khách hàng', icon: Icons.assignment_ind),
    // const MenuItem(title: 'Khách hàng', icon: Icons.settings),// deliverer
    const MenuItem(title: 'Bếp', icon: Icons.kitchen),
    const MenuItem(title: 'Trường', icon: Icons.school),
    const MenuItem(title: 'Cài đặt', icon: Icons.settings),
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
        return  const tmpPage2();
      case 6:
        return const KitchenView();
      case 7:
        return const SchoolView();
      case 8:
        return const tmpPage();
      default:
        return colorGreen();
    }
  }

  void onNavigationIndexChange(int destination) {
    selectedIndex.value = destination;
    selectedContent.value = setSelectedContent(destination);
  }

  void toggleNavigation() {
    isNavigationRailSelected.toggle();
  }
}

Widget initSelectedContent() {
  logger.i('initSelectedContent');
  return DashboardView();
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