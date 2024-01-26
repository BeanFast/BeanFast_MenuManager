import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/home_controller.dart';
import '/views/pages/widget/drawer_wdget.dart';

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
            Get.offAllNamed(_homeController.menuItems[destination].route);
            // _homeController.onNavigationIndexChange(destination);
          },
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
          color: const Color.fromARGB(255, 211, 19, 19),
        ),
        Expanded(
          child: _homeController.selectedContent.value,
        ),
      ],
    );
  }

  Widget drawerView() {
    // final title = Get.arguments as String;
    return Obx(
      () => Row(
        children: [
          AppDrawer(),
          Expanded(
            child: _homeController.selectedContent.value,
          ),
        ],
      ),
    );
  }
}
