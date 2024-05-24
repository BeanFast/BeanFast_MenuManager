import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';

class TextOrderStatus extends StatelessWidget {
  final OrderStatus status;
  const TextOrderStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    switch (status) {
      case OrderStatus.preparing:
        color = Colors.black54;
        break;
      case OrderStatus.cooking:
        color = Colors.black54;
        break;
      case OrderStatus.delivering:
        color = Colors.black54;
        break;
      case OrderStatus.completed:
        color = Colors.green;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }

    return Text(
      status.message,
      style: Get.textTheme.labelLarge!.copyWith(color: color),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
class TextGiftOrderStatus extends StatelessWidget {
  final ExchangeGiftStatus status;
  const TextGiftOrderStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    switch (status) {
      case ExchangeGiftStatus.preparing:
        color = Colors.black54;
        break;
      case ExchangeGiftStatus.delivering:
        color = Colors.black54;
        break;
      case ExchangeGiftStatus.completed:
        color = Colors.green;
        break;
      case ExchangeGiftStatus.cancelled:
        color = Colors.red;
        break;
      default:
        color = Colors.black;
    }

    return Text(
      status.message,
      style: Get.textTheme.labelLarge!.copyWith(color: color),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}