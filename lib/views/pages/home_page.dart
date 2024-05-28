import 'package:beanfast_menumanager/views/pages/widget/image_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '/contains/contrain.dart';
import '/controllers/home_controller.dart';
// import '/views/pages/widget/drawer_wdget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
              onSelected: (String result) {
                if (result == 'Tài khoản') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Thông tin bếp',
                          style: Get.textTheme.titleMedium,
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                'Code: ${currentKitchen.value!.code}',
                                style: Get.textTheme.bodyMedium,
                              ),
                              Text(
                                'Tên bếp: ${currentKitchen.value!.name}',
                                style: Get.textTheme.bodyMedium,
                              ),
                              Text(
                                'Địa chỉ: ${currentKitchen.value!.address}',
                                style: Get.textTheme.bodyMedium,
                              ),
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
                              Get.back();
                            },
                          ),
                          TextButton(
                            child: const Text('Đồng ý'),
                            onPressed: () {
                              Get.back();
                              Get.find<AuthController>().logOut();
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
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CustomNetworkImage(
                            currentKitchen.value?.imagePath ?? '',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        currentKitchen.value?.name.toString().capitalize ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium!.copyWith(),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            controller.toggleNavigation();
          },
        ),
      ),
      body: Obx(() {
        return controller.isNavigationRailSelected.value
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
              ...controller.menuItems.map(
                (e) => NavigationRailDestination(
                  icon: Icon(e.icon),
                  label: Text(e.title),
                ),
              ),
            ],
            onDestinationSelected: (destination) {
              controller.changePage(destination);
            },
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: controller.selectedContent.value,
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
                  for (int i = 0; i < controller.menuItems.length; i++)
                    ListTile(
                      leading: Icon(controller.menuItems[i].icon),
                      title: Text(controller.menuItems[i].title),
                      selected: selectedMenuIndex.value == i,
                      selectedTileColor:
                          const Color.fromARGB(255, 122, 184, 235),
                      onTap: () {
                        selectedMenuIndex.value = i;
                        controller.changePage(i);
                      },
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: controller.selectedContent.value,
          ),
        ],
      ),
    );
  }
}
