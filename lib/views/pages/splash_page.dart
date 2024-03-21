import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';
import '/enums/auth_state_enum.dart';
import 'home_page.dart';
import 'login_page.dart';
import '/utils/logger.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final AuthController _authController = Get.find();

  Future<void> initializeSettings() async {
    print('initializeSettings');
    _authController.checkLoginStatus();

    //Simulate other services for 3 seconds
    // await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError) {
            // return ErrorView(errorMessage: snapshot.error.toString());
            logger.e('snapshot.hasError: ${snapshot.error.toString()}');
            return LoginView();
          } else {
            return Obx(() {
              switch (_authController.authState.value) {
                case AuthState.authenticated:
                  return HomeView(); // get token -> get User
                // return const HomeView(); // get token -> get User
                case AuthState.unauthenticated:
                  return LoginView();
                default:
                  logger.e(
                      'Lỗi xác thực đăng nhập: ${snapshot.error.toString()}');
                  return LoginView();
                // return const ErrorView(
                //     errorMessage: 'Lỗi xác thực đăng nhập'); //
              }
            });
          }
        }
      },
    );
  }

  Scaffold waitingView() {
    return const Scaffold(
      body: Center(
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
      // Text('Loading...'),
      //   ],
      // ),
      // ),
    );
  }
}
