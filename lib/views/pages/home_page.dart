import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../controllers/auth_controller.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(
          child: Text('Click go to seconds'),
          onPressed: () {
            Get.offAndToNamed('/seconds');
            // Get.offAll(SecondsScreen);
          },
        ),
      ),
    );
  }
}

class SecondsView extends StatelessWidget {
  const SecondsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(
          child: Text('Click go to Home'),
          onPressed: () {
            Get.toNamed('/');
          },
        ),
      ),
    );
  }
}
