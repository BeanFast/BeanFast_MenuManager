import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmpPage2 extends StatelessWidget {
  const TmpPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                'https://picsum.photos/250?image=9',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                // color: Colors.green,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên của sản phầm 1',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('Đã bán 14',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Mô tả của sản phẩm 1: ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam eu feugiat nunc. Mauris facilisis eget est sit amet varius. Aliquam auctor lobortis nisi, ut fermentum elit tincidunt in. Etiam sit amet tincidunt nisl, vitae molestie justo. Nulla ut justo non leo semper elementum eu eu libero. Nam a vestibulum turpis, a vehicula quam. Pellentesque sit amet auctor massa, sit amet volutpat magna. Ut metus nibh, efficitur quis laoreet at, scelerisque vitae risus. Sed tempus dictum odio at varius. Aenean pulvinar et turpis ut commodo. In arcu ante, congue vitae enim a, sodales imperdiet orci. Duis quis neque velit. Fusce sed.',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Giá niêm yết: ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '100.000đ',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Giá bán: ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '150.000đ',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Số lượng: ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '10',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
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

class Controller extends GetxController {}
