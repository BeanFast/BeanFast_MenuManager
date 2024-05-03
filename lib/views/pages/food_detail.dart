import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/widget/image_default.dart';
import '/models/food.dart';
import '/enums/status_enum.dart';
import 'widget/row_info_item_widget.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView(this.food, {super.key});
  final Food food;
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
              CustomNetworkImage(food.imagePath.toString(),
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
                          title: 'Code: ', data: food.code.toString()),
                      RowInfoItemWidget(
                          title: 'Tên sản phẩm: ', data: food.name.toString()),
                      RowInfoItemWidget(
                          title: 'Giá: ', data: food.price.toString()),
                      RowInfoItemWidget(
                          title: 'Mô tả: ', data: food.description.toString()),
                      RowInfoItemWidget(
                          title: 'Trạng thái hoạt động: ',
                          data: FooodStatus.active.message),
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
