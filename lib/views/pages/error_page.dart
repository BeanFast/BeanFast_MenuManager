import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(
      {super.key, required this.errorMessage, required this.tryAgain});
  final String errorMessage;
  final void Function() tryAgain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              errorMessage,
              style: Get.theme.textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  print('tryAgain');
                  tryAgain();
                  // Get.back();
                },
                child: const Text('Thử lại'))
          ],
        ),
      ),
    );
  }
}
