import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(errorMessage, style: Get.theme.textTheme.headlineMedium,),
      ),
    );
  }
}
