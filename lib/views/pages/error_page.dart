import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    print(ErrorView);
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
