import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

import '/models/order.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.order});
  final Order order;

  void sortByDate() {
    order.orderActivities?.sort((a, b) => b.time!.compareTo(a.time!));
  }

  @override
  Widget build(BuildContext context) {
    sortByDate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đã giao hàng'),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Mã đơn hàng', style: Get.textTheme.labelLarge),
                    const Spacer(),
                    Text('#${order.code}', style: Get.textTheme.bodySmall),
                    TextButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: order.code.toString()));
                          Get.snackbar(
                            'Hệ thống',
                            'Đã sao chép mã đơn hàng',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.white,
                            duration: const Duration(seconds: 1),
                            colorText: Colors.black,
                          );
                        },
                        child: Text('SAO CHÉP',
                            style: Get.textTheme.bodySmall!
                                .copyWith(color: Colors.green)))
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                // Timeline
                FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0.3,
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.after,
                    contentsAlign: ContentsAlign.basic,
                    oppositeContentsBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              DateFormat('HH:mm dd/MM/yy')
                                  .format(order.orderActivities![index].time!),
                              style: Get.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    contentsBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(order.orderActivities![index].name.toString(),
                              style: Get.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    indicatorBuilder: (context, index) {
                      if (index == 0) {
                        return const OutlinedDotIndicator(
                          color: Colors.green,
                          size: 25,
                          child: Icon(
                            Iconsax.box_tick,
                            size: 15,
                          ),
                        );
                      } else if (index == 1) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.car,
                            size: 15,
                          ),
                        );
                      } else if (index == 3) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.box,
                            size: 15,
                          ),
                        );
                      } else if (index == 4) {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                          child: Icon(
                            Iconsax.note_text4,
                            size: 15,
                          ),
                        );
                      } else {
                        return const OutlinedDotIndicator(
                          color: Colors.grey,
                          size: 25,
                        );
                      }
                    },
                    connectorBuilder: (context, index, connectorType) {
                      return const DecoratedLineConnector(
                        thickness: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      );
                    },
                    itemCount: order.orderActivities!.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
