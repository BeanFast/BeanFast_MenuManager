import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contains/contrain.dart';
import '/controllers/home_controller.dart';
// import '/views/pages/widget/drawer_wdget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý bếp'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
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
    return Obx(
      () => Row(
        children: [
          NavigationRail(
            minWidth: 64,
            // selectedIndex: widget.currentIndex,
            selectedIndex: selectedMenuIndex.value,
            destinations: [
              ..._homeController.menuItems.map(
                (e) => NavigationRailDestination(
                  icon: Icon(e.icon),
                  label: Text(e.title),
                ),
              ),
            ],
            onDestinationSelected: (destination) {
              _homeController.changePage(destination);
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
      ),
    );
  }

  Widget drawerView() {
    return Obx(
      () => Row(
        children: [
          Drawer(
            width: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const DrawerHeader(
                  //   child: Center(
                  //     child: Text('Menu'),
                  //   ),
                  // ),
                  for (int i = 0; i < _homeController.menuItems.length; i++)
                    ListTile(
                      leading: Icon(_homeController.menuItems[i].icon),
                      title: Text(_homeController.menuItems[i].title),
                      selected: selectedMenuIndex.value == i,
                      onTap: () {
                        selectedMenuIndex.value = i;
                        _homeController.changePage(i);
                        // _homeController.selectedContent.value =
                        //     _homeController.setSelectedContent(i);
                      },
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _homeController.selectedContent.value,
          ),
        ],
      ),
    );
  }
}
