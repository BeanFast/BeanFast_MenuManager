import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/session_detail_page.dart';
import '/contains/contrain.dart';
import '/utils/menu_item.dart';
import '/views/pages/create_session_page.dart';
import '/views/pages/exchange_gift_page.dart';
import '/views/pages/category_page.dart';
import '/views/pages/gift_page.dart';
import '/views/pages/food_page.dart';
import '/views/pages/dashboard_page.dart';
import '/views/pages/school_page.dart';
import '/views/pages/menu_page.dart';
import '/views/pages/order_page.dart';

class HomeController extends GetxController {
  RxBool isNavigationRailSelected = true.obs;
  // index of menuItem
  Rx<Widget> selectedContent = Rx<Widget>(const DashboardView());

  // menu mặc định
  List<MenuItem> menuItems = [
    const MenuItem(title: 'Báo cáo', icon: Icons.space_dashboard_outlined),
    const MenuItem(title: 'Thức ăn', icon: Icons.fastfood_outlined),
    const MenuItem(title: 'Thực đơn', icon: Icons.menu_outlined),
    const MenuItem(title: 'Đơn đặt món', icon: Icons.assignment_outlined),
    const MenuItem(title: 'Đơn đổi quà', icon: Icons.assignment_turned_in_outlined),
    const MenuItem(title: 'Trường Học', icon: Icons.school_outlined),
    const MenuItem(title: 'Quà', icon: Icons.card_giftcard_outlined),
    const MenuItem(title: 'Danh mục sản phẩm', icon: Icons.category_outlined),
  ];

  // index là vị trí của menuItems
  Widget setSelectedContent(int index) {
    switch (index) {
      case 0:
        return const DashboardView();
      // return const SessionDetailPage(
      //     sessionId: '73a25f1c-aeaa-404d-9d23-1675225185ac');
      // return const DashboardView();
      case 1:
        return const FoodView();
      case 2:
        return const MenuView();
      case 3:
        return const OrderView();
      case 4:
        return const ExchangeGiftView();
      case 5:
        return const SchoolView();
      case 6:
        return const GiftView();
      case 7:
        return const CategoryView();
      default:
        return const DashboardView();
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
