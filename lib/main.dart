import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding.dart';
import 'views/pages/splash_page.dart';

Future<void> main() async {
  await GetStorage.init(); // init local storage
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
      initialRoute: "/",
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashView(),
          binding: AuthBindingController(), // create dependencie auth
          // transition: Transition.fade,
        ),
      ],
    );
  }
}
