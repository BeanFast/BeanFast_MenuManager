import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

final HomeController _homeController = Get.find();

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        minWidth: 64,
        // selectedIndex: widget.currentIndex,
        selectedIndex: _homeController.selectedIndex.value,
        destinations: [
          ..._homeController.menuItems.map(
            (e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.title),
            ),
          ),
        ],
        onDestinationSelected: (destination) {
          _homeController.onNavigationIndexChange(destination);
        },
      ),
      VerticalDivider(
        width: 1,
        thickness: 1,
        color: Colors.grey[300],
      ),
      Expanded(
        child: _homeController.selectedContent.value,
      ),
    ],
  );
}

Widget drawerView() {
  // final title = Get.arguments as String;
  return Obx(() => Row(
        children: [
          Drawer(
            width: 164,
            child: Column(
              children: [
                for (int i = 0; i < _homeController.menuItems.length; i++)
                  ListTile(
                    leading: Icon(_homeController.menuItems[i].icon),
                    title: Text(_homeController.menuItems[i].title),
                    selected: _homeController.selectedIndex.value == i,
                    onTap: () {
                      _homeController.selectedIndex.value = i;
                      _homeController.selectedContent.value =
                          // _homeController.menuItems[i].
                          _homeController.setSelectedContent(i);
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: _homeController.selectedContent.value,
          ),
        ],
      ));
}
