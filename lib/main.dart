import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding.dart';
import 'contrains/theme.dart';
import 'controllers/home_controller.dart';
import 'views/pages/splash_page.dart';
import 'views/pages/dashboard_page.dart';
import 'views/pages/food_page.dart';
import 'views/pages/food_detail.dart';
import 'views/pages/menu_detail_page.dart';
import 'package:beanfast_menumanager/views/pages/manage_menu_page.dart';

Future<void> main() async {
  await GetStorage.init(); // init local storage
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeanFast',
      theme: AppTheme.defaulTheme,
      initialRoute: "/",
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashView(),
          binding: AuthBindingController(),
          // transition: Transition.fade,
        ),
        GetPage(
          name: '/dashboard',
          page: () => DashboardView(),
          binding: FoodBindingController(),
        ),
        GetPage(
          name: '/food',
          page: () => const FoodView(),
          binding: FoodBindingController(),
        ),
        GetPage(
          name: '/food-detail',
          page: () => const FoodDetailView(),
          binding: FoodBindingController(),
        ),
        GetPage(
          name: '/menu-detail',
          page: () => const MenuDetailView(),
          binding: MenuDetailBindingController(),
        ),
        GetPage(
          name: '/manage-menu',
          page: () => const ManageMenuView(),
          binding: ManageMenuViewBindingController(),
        ),
      ],
    );
  }
}
