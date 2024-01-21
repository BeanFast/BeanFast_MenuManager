import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'views/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    Get.put(AuthController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: [
        GetPage(
          name: '/',
          page: () {
            return const Home();
          },
          binding: LoginBindingController(),
        ),
        // GetPage(name: '/', page: () => ImageSlider()),
      ],
      home: Obx(() {
        switch (authController.authState.value) {
          case AuthState.authenticated:
            print('authenticated');// get token -> get User 
            return Home();
          case AuthState.unauthenticated:
            print('unauthenticated');
            return Login();
          default:
            return SplashScreen(); // Trường hợp mặc định, có thể không cần thiết
        }
      }),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashScreen'),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trạng thái không xác định'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    );
  }
}
