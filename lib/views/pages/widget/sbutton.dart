import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SButton extends StatelessWidget {
  const SButton({
    super.key,
    required this.color,
    required this.borderColor,
    required this.text,
    required this.textStyle,
    required this.onPressed,
  });

  final Color color;
  final Color borderColor;
  final String text;
  final TextStyle? textStyle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: Get.width / 1.2,
        height: 45,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 1)),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}