import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contains/contrain.dart';
import '/controllers/home_controller.dart';
// import '/views/pages/widget/drawer_wdget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Quản lý bếp'),
            const Spacer(),
            PopupMenuButton<String>(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              icon: const Icon(Icons.settings),
              onSelected: (String result) {
                if (result == 'Tài khoản') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Thông tin tài khoản'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Email tài khoản:'),
                              Text('Thông tin 1:'),
                              Text('Thông tin 2:'),
                              Text('Thông tin 3:'),
                              Text('Thông tin 4:'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Đóng'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (result == 'Đăng xuất') {
                  // Handle logout
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:
                            Text('Xác nhận', style: Get.textTheme.titleMedium),
                        content: Text('Bạn có chắc chắn muốn đăng xuất không?',
                            style: Get.textTheme.bodyMedium),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Returns false when Cancel is clicked
                            },
                          ),
                          TextButton(
                            child: const Text('Đồng ý'),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(true); // Returns true when OK is clicked
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Tài khoản',
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Tài khoản'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Đăng xuất',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Đăng xuất'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
            backgroundColor: Colors.white,
            elevation: 2,
            minWidth: 64,
            selectedIndex: selectedMenuIndex.value,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
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
            elevation: 2,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            width: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < _homeController.menuItems.length; i++)
                    ListTile(
                      leading: Icon(_homeController.menuItems[i].icon),
                      title: Text(_homeController.menuItems[i].title),
                      selected: selectedMenuIndex.value == i,
                      selectedTileColor:
                          const Color.fromARGB(255, 122, 184, 235),
                      onTap: () {
                        selectedMenuIndex.value = i;
                        _homeController.changePage(i);
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
