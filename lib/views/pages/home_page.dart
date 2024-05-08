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
        title: Row(
          children: [
            const Text('Quản lý bếp'),
            const Spacer(),
            PopupMenuButton<String>(
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
                        title: const Text('Xác nhận'),
                        content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Hủy'),
                            onPressed: () {
                              Navigator.of(context).pop(false); // Returns false when Cancel is clicked
                            },
                          ),
                          TextButton(
                            child: const Text('Đồng ý'),
                            onPressed: () {
                              Navigator.of(context).pop(true); // Returns true when OK is clicked
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
