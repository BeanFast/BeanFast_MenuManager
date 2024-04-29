import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '/services/auth_service.dart';
import '/utils/logger.dart';
import '/enums/auth_state_enum.dart';

class AuthController extends GetxController with CacheManager {
  Rx<AuthState> authState = AuthState.unauthenticated.obs;
  // final RxBool logged = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString errorMessage = ''.obs;
  // final _authState = Rx<AuthState>(AuthState.unknown);

  // Stream<AuthState> get authStateChanges => _authState.stream;
  void changeAuthState(AuthState newState) {
    authState.value = newState;
  }

  void checkLoginStatus() {
    final String? token = getToken();
    logger.e('token - ${token != null}');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final expiryTimestamp = decodedToken["exp"];
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (expiryTimestamp < currentTime) {
        changeAuthState(AuthState.authenticated);
        return;
      }
    }
    logOut();
  }

  void login() async {
    emailController.text = 'kitchen.manager01.beanfast@gmail.com';
    passwordController.text = '12345678';
    try {
      logger.e('login');
      var response = await AuthService()
          .login(emailController.text, passwordController.text);
      if (response.statusCode == 200) {
        changeAuthState(AuthState.authenticated);
        await saveToken(response.data['data']['accessToken']); //Token is cached
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        errorMessage.value = 'Tài khoản hoặc mật khẩu không đúng';
      }
    }
  }

  void logOut() {
    changeAuthState(AuthState.unauthenticated);
    removeToken();
  }
}

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.MANAGERTOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.MANAGERTOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.MANAGERTOKEN.toString());
  }
}

// ignore: constant_identifier_names
enum CacheManagerKey { MANAGERTOKEN }
