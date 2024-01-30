import 'package:beanfast_menumanager/views/pages/menu_create_page.dart';
import 'package:beanfast_menumanager/views/pages/menu_management_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding.dart';
import 'views/pages/splash_page.dart';
import 'contrains/theme.dart';
import 'controllers/home_controller.dart';
import 'views/pages/dashboard_page.dart';
import 'views/pages/food_page.dart';

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
          binding: AuthBindingController(), // create dependencie auth
          // transition: Transition.fade,
        ),
        GetPage(
          name: '/dashboard',
          page: () => DashboardView(),
          binding: FoodBindingController(),
          // transition: Transition.fade,
        ),
        GetPage(
          name: '/food',
          page: () => FoodView(),
          binding: FoodBindingController(),
          // transition: Transition.fade,
        ),
        GetPage(
          name: '/menu-management',
          page: () => const MenuManagementView(),
          // binding: FoodBindingController(),
          // transition: Transition.fade,
        ),
        GetPage(
          name: '/menu-create',
          page: () => const MenuCreateView(),
          // binding: FoodBindingController(),
          // transition: Transition.fade,
        ),
      ],
    );
  }
}
