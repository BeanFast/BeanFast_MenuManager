import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class Login extends StatelessWidget {
  final AuthController _controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  final _isPasswordHidden = true.obs;
  final RxBool _isChecked = false.obs;

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            bannerLogin(),
            loginForm(),
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 500,
          height: 900,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                TextFormField(
                  controller: _controller.usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên đăng nhập',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên đăng nhập';
                    }
                    if (value.length < 3) {
                      return 'Tên đăng nhập phải có ít nhất 3 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _isPasswordHidden.value = !_isPasswordHidden.value;
                      },
                    ),
                  ),
                  obscureText: _isPasswordHidden.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 8) {
                      return 'Mật khẩu phải có ít nhất 8 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked.value,
                      onChanged: (value) {
                        _isChecked.value = value!;
                      },
                    ),
                    const Text('Lưu mật khẩu'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Your onPressed code for "Forgot Password" here
                      },
                      child: const Text('Quên mật khẩu?'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Text color
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green), // Background color
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Đăng nhập thành công')),
                      //   );
                      //   // Get.to(ImageSlider());
                      // }
                      _controller.authState.value = AuthState.authenticated;
                      print('button: ${_controller.authState.value}');
                    },
                    child: const Text('Đăng nhập'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bannerLogin() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          "images/login.png",
          width: Get.size.width * 0.4,
        ),
      ),
    );
  }
}

class LoginBindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
