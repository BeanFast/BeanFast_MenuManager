import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/school.dart';
import '/views/pages/widget/image_default.dart';
import 'widget/row_info_item_widget.dart';

class SchoolDetailView extends StatelessWidget {
  const SchoolDetailView(this.school, {super.key});
  final School school;
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
              CustomNetworkImage(school.imagePath.toString(),
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
                          title: 'Code: ', data: school.code.toString()),
                      RowInfoItemWidget(
                          title: 'Tên trường: ',
                          data: school.name.toString()),
                      RowInfoItemWidget(
                          title: 'Địa chỉ: ',
                          data:
                              '${school.address.toString()}, ${school.area!.ward.toString()}, ${school.area!.district.toString()}, ${school.area!.city.toString()}'),
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
