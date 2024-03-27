// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controllers/home_controller.dart';

// class AppDrawer extends StatelessWidget {
//   AppDrawer({super.key});
//   final HomeController _homeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: 200,
//       child: Column(
//         children: [
//           const DrawerHeader(
//             child: Center(
//               child: Text('Menu'),
//             ),
//           ),
//           for (int i = 0; i < _homeController.menuItems.length; i++)
//             ListTile(
//               leading: Icon(_homeController.menuItems[i].icon),
//               title: Text(_homeController.menuItems[i].title),
//               selected: _homeController.selectedIndex.value == i,
//               onTap: () {
//                 Get.offNamed(_homeController.menuItems[i].route);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }