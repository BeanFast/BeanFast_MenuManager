// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:intl/intl.dart';

// import '/utils/data_table.dart';
// import '/utils/logger.dart';
// import '/views/pages/loading_page.dart';
// import '/enums/status_enum.dart';
// import '/models/order.dart';
// import '/services/order_service.dart';
// import '/utils/format_data.dart';
// import 'order_detail_page.dart';
// import 'widget/button_data_table.dart';

// class MyDataTableView extends GetView<OrderDemoController> {
//   const MyDataTableView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(OrderDemoController());
//     return Scaffold(
//       appBar: AppBar(title: const Text('PaginatedDataTable2 with GetX')),
//       body: LoadingView(
//         future: controller.fetchData,
//         child: SafeArea(
//           child: GetBuilder<OrderDemoController>(
//             builder: (controller) {
//               return Obx(
//                 () => PaginatedDataTable2(
//                   // Dữ liệu bảng
//                   header: const Text('Data Table Header'),
//                   availableRowsPerPage: const [2, 5, 10, 30, 100],
//                   rowsPerPage: controller.rowsPerPage.value,
//                   columnSpacing: 0,
//                   // headingRowColor: MaterialStateColor.resolveWith(
//                   //     (states) => Colors.grey[200]!),
//                   onRowsPerPageChanged: (value) {
//                     controller.changeRowsPerPage(value!);
//                   },
//                   onPageChanged: (int value) {
//                     logger.e('onPageChanged - $value');
//                     // controller.changePage(value);
//                   },
//                   columns: const [
//                     DataColumn2(label: Text('Column 1')),
//                     DataColumn2(label: Text('Column 2')),
//                     DataColumn2(label: Text('Column 3')),
//                     DataColumn2(label: Text('Column 4')),
//                     DataColumn2(label: Text('Column 5')),
//                     DataColumn2(label: Text('Column 6')),
//                     DataColumn2(label: Text('Column 7')),
//                     DataColumn2(label: Text('Column 8')),
//                   ],
//                   // ignore: invalid_use_of_protected_member
//                   source: MyDataTableSource(rows: controller.rows.value),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   DataRow setRow(Order order) {
//     return DataRow(
//       cells: [
//         DataCell(Text(order.code.toString())),
//         DataCell(
//           Text(order.profile!.fullName.toString()),
//         ),
//         DataCell(Text(order.paymentDate == null
//             ? 'Chưa có'
//             : DateFormat('dd/MM/yyyy').format(order.paymentDate!))),
//         DataCell(Text(order.deliveryDate == null
//             ? 'Chưa có'
//             : DateFormat('dd/MM/yyyy').format(order.deliveryDate!))),
//         DataCell(Text(order.sessionDetail!.code.toString())),
//         DataCell(Text(order.orderDetails!.length.toString())),
//         DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
//         DataCell(Row(
//           children: [
//             const Spacer(),
//             DetailButtonDataTable(onPressed: () {
//               Get.to(OrderDetailView(order));
//             })
//           ],
//         )),
//       ],
//     );
//   }
// }

// // class MyDataTableSource extends DataTableSource {
// //   final List<DataRow> rows;

// //   MyDataTableSource({required this.rows});

// //   @override
// //   DataRow? getRow(int index) {
// //     if (index >= rows.length) return null;
// //     return rows[index];
// //   }

// //   @override
// //   bool get isRowCountApproximate => false;

// //   @override
// //   int get rowCount => rows.length;

// //   @override
// //   int get selectedRowCount => 0;
// // }

// class OrderDemoController extends PaginatedDataTableController<Order> {
//   @override
//   Future<void> fetchData() async {
//     try {
//       final data = await OrderService().getByStatus(OrderStatus.cancelled);
//       dataList = data;
//       setDataTable(dataList);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   void setDataTable(List<Order> list) {
//     rows.value = list.map((data) {
//       return const MyDataTableView().setRow(data);
//     }).toList();
//   }
// }

// abstract class PaginatedDataTableController<T> extends GetxController {
//   RxList<DataRow> rows = <DataRow>[].obs;
//   List<T> dataList = [];
//   var currentPage = 1.obs;
//   var rowsPerPage = PaginatedDataTable.defaultRowsPerPage.obs;
//   Rx<int>? sortColumnIndex;
//   Rx<bool> sortAscending = true.obs;


//   // Future<void> refreshData() async {
//   //   await fetchData();
//   //   // await fetchData(currentPage.value, rowsPerPage.value);
//   //   setDataTable(dataList);
//   // }

//   // Future<void> changePage(int page) async {
//   //   // Cập nhật trang hiện tại
//   //   currentPage.value = page;
//   //   // Load data for the new page
//   //   await fetchData();
//   // }

//   Future<void> changeRowsPerPage(int rows) async {
//     // Cập nhật số hàng trên mỗi trang
//     rowsPerPage.value = rows;
//     // Load data for the new page with updated rowsPerPage
//     // await fetchData();
//   }

//   // void sort<T>(
//   //   Comparable<T> Function(T) getField,
//   //   int columnIndex,
//   //   bool ascending,
//   // ) {
//   //   dessertsDataSource.sort<T>(getField, ascending);

//   //   sortColumnIndex = columnIndex;
//   //   sortAscending = ascending;
//   // }

//   Future fetchData();
//   void setDataTable(List<T> list);
// }
