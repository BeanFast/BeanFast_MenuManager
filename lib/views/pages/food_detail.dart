import 'package:beanfast_menumanager/views/pages/widget/image_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/loading_page.dart';
import '/controllers/food_controller.dart';
import '/enums/status_enum.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class FoodDetailView extends GetView<FoodController> {
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      future: controller.getByCode,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chi tiết sản phẩm')),
        ),
        body: Obx(
          () => controller.model.value == null
              ? Center(
                  child: Text(
                    'Không tìm thấy sản phẩm',
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 10, right: 10, bottom: 10),
                  child: Center(
                    child: Column(
                      children: [
                        CustomNetworkImage(
                            controller.model.value!.imagePath.toString(),
                            height: Get.height * 0.4,
                            width: Get.height * 0.4),
                        TextFieldItem(
                            title: 'Code: ',
                            data: controller.model.value!.code.toString()),
                        TextFieldItem(
                            title: 'Tên sản phẩm: ',
                            data: controller.model.value!.name.toString()),
                        TextFieldItem(
                            title: 'Giá: ',
                            data: controller.model.value!.price.toString()),
                        TextFieldItem(
                            title: 'Mô tả: ',
                            data:
                                controller.model.value!.description.toString()),
                        TextFieldItem(
                            title: 'Trạng thái hoạt động: ',
                            data: FooodStatus.active.message),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
