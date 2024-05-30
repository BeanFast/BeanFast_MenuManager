import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/views/pages/menu_create_page.dart';
import 'binding.dart';
import 'contains/theme.dart';
import 'controllers/home_controller.dart';
import 'routes/app_routes.dart';
import 'views/pages/dashboard_page.dart';
import 'views/pages/food_page.dart';
import 'views/pages/menu_detail_page.dart';
import 'views/pages/network_page.dart';
import 'views/pages/session_page.dart';

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
          page: () => const NetworkView(),
          binding: AuthBindingController(),
          // transition: Transition.fade,
        ),
        GetPage(
          name: AppRoutes.dashboard,
          page: () =>const DashboardView(),
          binding: FoodBindingController(),
        ),
        GetPage(
          name: AppRoutes.food,
          page: () => const FoodView(),
          binding: FoodBindingController(),
        ),
        // GetPage(
        //   name: AppRoutes.foodDetail,
        //   page: () => const FoodDetailView(),
        //   binding: FoodBindingController(),
        // ),
        GetPage(
          name: AppRoutes.menuDetail,
          page: () => const MenuDetailView(),
          binding: MenuDetailBindingController(),
        ),
        GetPage(
          name: AppRoutes.menuCreate,
          page: () => const MenuCreateView(),
        ),
        GetPage(
          name: AppRoutes.manageMenu,
          page: () => const SessionView(),
          binding: ManageMenuViewBindingController(),
        ),
      ],
    );
  }
}
