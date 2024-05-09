import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/kitchen.dart';
import '/views/pages/widget/image_default.dart';
import 'widget/row_info_item_widget.dart';

class KitchenDetailView extends StatelessWidget {
  const KitchenDetailView(this.kitchen, {super.key});
  final Kitchen kitchen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết sản phẩm')),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomNetworkImage(kitchen.imagePath.toString(),
                  height: Get.height * 0.4, width: Get.height * 0.4),
              const SizedBox(height: 20),
              Card(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 30,
                    bottom: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RowInfoItemWidget(
                          title: 'Code: ', data: kitchen.code.toString()),
                      RowInfoItemWidget(
                          title: 'Tên bếp: ',
                          data: kitchen.name.toString()),
                      RowInfoItemWidget(
                          title: 'Địa chỉ: ',
                          data:
                              '${kitchen.address.toString()}, ${kitchen.area!.ward.toString()}, ${kitchen.area!.district.toString()}, ${kitchen.area!.city.toString()}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
