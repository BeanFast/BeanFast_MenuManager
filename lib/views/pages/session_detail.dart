// import 'package:beanfast_menumanager/contains/theme_color.dart';
// import 'package:beanfast_menumanager/enums/status_enum.dart';
// import 'package:beanfast_menumanager/views/pages/widget/order_tabview.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SessionDetailPage extends StatelessWidget {
//   const SessionDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cổng giao số 1'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: Card(
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text('Code: ', style: Get.textTheme.titleMedium),
//                           const SizedBox(width: 10),
//                           Text('#12345678', style: Get.textTheme.bodyMedium),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Text('Mã thực đơn: ',
//                               style: Get.textTheme.titleMedium),
//                           const SizedBox(width: 10),
//                           Text('#12345678', style: Get.textTheme.bodyMedium),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Text('Thời gian giao hàng: ',
//                               style: Get.textTheme.titleMedium),
//                           const SizedBox(width: 10),
//                           Row(
//                             children: [
//                               Text('Từ 10:20 01/01/2021',
//                                   style: Get.textTheme.bodyMedium),
//                               Text(' đến 10:20 01/01/2021',
//                                   style: Get.textTheme.bodyMedium),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Text('Số lượng nhân viên giao hàng: ',
//                               style: Get.textTheme.titleMedium),
//                           const SizedBox(width: 10),
//                           Text('4', style: Get.textTheme.bodyMedium),
//                           const SizedBox(width: 10),
//                           GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title:  Text('Nhân viên giao hàng',
//                   style: Get.textTheme.titleMedium),
//                                     content: SizedBox(
//                                       height: Get.height * 0.5,
//                                       width: Get.width * 0.5,
//                                       child: SingleChildScrollView(
//                                         child: Column(
//                                           children: List.generate(
//                                             20,
//                                             (index) => Card(
//                                               child: ListTile(
//                                                 title: Text('ID: $index' ,style: Get.textTheme.bodyMedium),
//                                                 subtitle:
//                                                      Text('Nguyễn văn A',style: Get.textTheme.bodySmall),
//                                                 trailing: IconButton(
//                                                     icon: const Icon(
//                                                         Icons.delete_outline),
//                                                     onPressed: () {
//                                                       // Handle delete deliverer here
//                                                     }),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     actions: <Widget>[
//                                       Container(
//                                         padding: const EdgeInsets.all(15),
//                                         child: ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 ThemeColor.bgColor2,
//                                           ),
//                                           onPressed: () {
//                                             // Handle add deliverer here
//                                           },
//                                           child:  Text(
//                                               'Thêm nhân viên giao hàng',style: Get.textTheme.bodyMedium),
//                                         ),
//                                       )
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             child: const Icon(Icons.remove_red_eye_outlined,
//                                 size: 20),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Text('Tổng đơn hàng: ',
//                               style: Get.textTheme.bodyMedium),
//                           const SizedBox(width: 10),
//                           Text('40', style: Get.textTheme.bodyMedium),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       DefaultTabController(
//                         length: 4,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             const TabBar(
//                               tabs: [
//                                 Tab(text: 'Đang chuẩn bị'),
//                                 Tab(text: 'Đang giao'),
//                                 Tab(text: 'Hoàn thành'),
//                                 Tab(text: 'Đã hủy'),
//                               ],
//                             ),
//                             SizedBox(
//                               height: Get.height * 0.8,
//                               child: const TabBarView(
//                                 children: [
//                                   OrderTabView(
//                                     status: OrderStatus.preparing,
//                                   ), // Đang chuẩn bị
//                                   OrderTabView(
//                                     status: OrderStatus.delivering,
//                                   ), // Đang giao
//                                   OrderTabView(
//                                     status: OrderStatus.completed,
//                                   ), // Hoàn thành
//                                   OrderTabView(
//                                     status: OrderStatus.cancelled,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
