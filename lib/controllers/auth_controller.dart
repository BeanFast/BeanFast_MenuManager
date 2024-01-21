import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../models/user.dart';

enum AuthState {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthController extends GetxController {
  // late Rx<Account?> account;
  Rx<AuthState> authState = AuthState.unauthenticated.obs;
  // final RxBool logged = false.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // final _authState = Rx<AuthState>(AuthState.unknown);

  // Stream<AuthState> get authStateChanges => _authState.stream;
  void changeAuthState(AuthState newState) {
    authState.value = newState;
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

  // void signOut() {
  //   try {
  //     auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
