import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataView extends StatelessWidget {
  final bool hasData;
  final Widget child;
  final String message;

  const DataView(
      {super.key,
      required this.hasData,
      required this.message,
      required this.child});

  @override
  Widget build(BuildContext context) {
    if (hasData) {
      return child;
    }
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              "assets/images/order_image.png",
            ),
          ),
          Text(
            message,
            style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
