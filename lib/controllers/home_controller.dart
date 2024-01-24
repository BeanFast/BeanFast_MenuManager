import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:beanfast_menumanager/views/pages/dashboard_page.dart';
import 'package:beanfast_menumanager/views/pages/food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/menu_item.dart';

Map<int, Widget> list = {};

class HomeController extends GetxController {
  RxBool isNavigationRailSelected = true.obs;
  RxInt selectedIndex = 0.obs; // index of menuItem
  Rx<Widget> selectedContent = colorRed().obs;

  // menu mặc định
  List<MenuItem> menuItems = [
    const MenuItem(title: 'Home', icon: Icons.home, route: ''),
    const MenuItem(title: 'Dashboard', icon: Icons.dashboard, route: ''),
    const MenuItem(title: 'Setting', icon: Icons.settings, route: ''),
  ];

  // index là vị trí của menuItems
  Widget setSelectedContent(int index) {
    switch (index) {
      case 0:
        return colorRed();
      case 1:
        return DashboardSample(isShowingMainData: false,);
      case 2:
        return FoodView();
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

Widget colorRed() {
  logger.i('ColorRed');
  return Scaffold(body: Container(color: Colors.red));
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
