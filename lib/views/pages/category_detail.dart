import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/category.dart';
import '/views/pages/widget/image_default.dart';
import 'widget/row_info_item_widget.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView(this.category, {super.key});
  final Category category;
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
              CustomNetworkImage(category.imagePath.toString(),
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
                          title: 'Code: ', data: category.code.toString()),
                      RowInfoItemWidget(
                          title: 'Tên loại: ', data: category.name.toString()),
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
