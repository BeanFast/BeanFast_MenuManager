import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../enums/auth_state_enum.dart';
import '../models/user.dart';



class AuthController extends GetxController with CacheManager {

  late Rx<Account?> account;
  Rx<AuthState> authState = AuthState.unauthenticated.obs;
  // final RxBool logged = false.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // final _authState = Rx<AuthState>(AuthState.unknown);

  // Stream<AuthState> get authStateChanges => _authState.stream;
  void changeAuthState(AuthState newState) {
    authState.value = newState;
  }

  void checkLoginStatus() {
    final token = getToken();
    print('token: ${token}');
    if (token != null) {
      changeAuthState(AuthState.authenticated);
    }
  }

  final _username = "".obs;
  final _password = "".obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   firebaseUser = Rx<User?>(auth.currentUser);
  //   firebaseUser.bindStream(auth.userChanges());

  //   ever(firebaseUser, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user != null) {
  //     // user is logged in
  //     Get.offAll(() => const Home());
  //   } else {
  //     // user is null as in user is not available or not logged in
  //     Get.offAll(() => Login());
  //   }
  // }

  // void register(String email, String password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     // this is solely for the Firebase Auth Exception
  //     // for example : password did not match
  //     print(e.message);
  //     // Get.snackbar("Error", e.message!);
  //     Get.snackbar(
  //       "Error",
  //       e.message!,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } catch (e) {
  //     // this is temporary. you can handle different kinds of activities
  //     //such as dialogue to indicate what's wrong
  //     print(e.toString());
  //   }
  // }

  // void login(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     // this is solely for the Firebase Auth Exception
  //     // for example : password did not match
  //     print(e.message);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  void login() async {
    changeAuthState(AuthState.authenticated);
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    //Token is cached
    await saveToken(token);
  }

  void logOut() {
    changeAuthState(AuthState.unauthenticated);
    removeToken();
  }
  // void signOut() {
  //   try {
  //     auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }
}

enum CacheManagerKey { TOKEN }
