import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
        automaticallyImplyLeading: false,
        leading: ElevatedButton(
          child: const Icon(Icons.menu),
          onPressed: () {
            _homeController.toggleNavigation();
          },
        ),
      ),
      body: Obx(() {
        return _homeController.isNavigationRailSelected.value
            ? navigaView()
            : drawerView();
      }),
    );
  }
}

Widget navigaView() {
  return Row(
    children: [
      NavigationRail(
        // selectedIndex: widget.currentIndex,
        selectedIndex: 1,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text('Home'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
          ),
        ],
        onDestinationSelected: (destination) {
          // Do something when a destination is selected.
        },
      ),
      VerticalDivider(
        width: 1,
        thickness: 1,
        color: Colors.grey[300],
      ),
      Expanded(
        child: Container(
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget drawerView() {
  return Row(
    children: [
      Drawer(
        child: ListView(
          children: const [
            ListTile(
              title: Text('Item 1'),
            ),
            ListTile(
              title: Text('Item 2'),
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.red,
        ),
      ),
    ],
  );
}
