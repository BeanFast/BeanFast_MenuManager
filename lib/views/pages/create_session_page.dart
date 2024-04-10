import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmpPage extends StatelessWidget {
  const TmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thời gian bắt đầu', style: TextStyle(fontSize: 16),),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Bắt đầu',
                        // floatingLabelAlignment:
                        //     FloatingLabelAlignment.center
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Kết thúc',
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    const Text('Thời gian phát hành', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Bắt đầu',
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Kết thúc',
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    const Text('Cổng', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                          child: Column(
                        children: List.generate(
                          10,
                          (index) => Container(
                            margin:
                                const EdgeInsets.only(bottom: 2.5, top: 2.5),
                            child: Row(
                              children: <Widget>[
                                Obx(
                                  () => Checkbox(
                                    value: c.isChecked[index],
                                    onChanged: (bool? value) {
                                      c.toggle(index);
                                    },
                                  ),
                                ),
                                Text('Cổng ${index + 1}'),
                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                        label: const Text('Tạo'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Controller extends GetxController {
  // final int numberOfGate = 10;
  var isChecked = List<bool>.filled(10, false).obs;

  void toggle(int index) => isChecked[index] = !isChecked[index];
}