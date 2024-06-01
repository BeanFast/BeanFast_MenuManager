import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  final _isPasswordHidden = true.obs;

  LoginView({super.key});

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
        child: Container(
          alignment: Alignment.center,
          width: 500,
          height: 900,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                    controller: controller.emailController,
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
                      // Add this to validate email
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Vui lòng nhập email hợp lệ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
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
                  ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: _isChecked.value,
                  //       onChanged: (value) {
                  //         _isChecked.value = value!;
                  //       },
                  //     ),
                  //     const Text('Lưu mật khẩu'),
                  //     const Spacer(),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Your onPressed code for "Forgot Password" here
                  //       },
                  //       child: const Text('Quên mật khẩu?'),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 20,
                    child: Text(controller.errorMessage.value),
                  ),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child:  Text('Đăng nhập',style:  Get.textTheme.bodyMedium!.copyWith(color: Colors.white) ),
                    ),
                  ),
                ],
              ),
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
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: Get.size.width * 0.3,
          child: Image.asset(
            "images/login.png",
          ),
        ),
      ),
    );
  }
}
