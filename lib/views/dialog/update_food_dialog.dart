import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

void showUpdateFoodDialog() {
  Get.dialog(
    ConstrainedBox(
      constraints:  BoxConstraints(maxWidth: Get.width * 0.8),
      child: AlertDialog(
        title: const Text('Thông tin món ăn'),
        content: SingleChildScrollView(
          child: SizedBox(
         width:   Get.width * 0.8,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: Image.network(
                    'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: TextButton(
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.add, size: 20,),
                        Text('Chọn Ảnh', style: Get.textTheme.bodyMedium),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: TextFormField(
                    initialValue: 'Tên sản phẩm',
                    decoration: const InputDecoration(
                      labelText: 'Tên Sản Phẩm',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên sản phẩm';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: TextFormField(
                    initialValue: 'Giá',
                    decoration: const InputDecoration(
                      labelText: 'Giá',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập giá';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Giá không hợp lệ';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: DropdownButtonFormField<String>(
                    value: 'Loại 1',
                    decoration: const InputDecoration(labelText: 'Loại'),
                    items: <String>[
                      'Loại 1',
                      'Loại 2',
                      'Loại 3',
                      'Loại 4',
                      'Loại 5',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui Lòng chọn loại';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {},
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.add, size: 20,),
                Text('Cập nhật', style: Get.textTheme.bodyMedium),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
