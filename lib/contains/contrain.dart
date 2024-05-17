import 'package:get/get.dart';

import '/models/kitchen.dart';
import '/enums/menu_index_enum.dart';
import '/enums/auth_state_enum.dart';
import '/models/user.dart';

Rx<User?> currentUser = Rx<User?>(null);
Rx<Kitchen?> currentKitchen = Rx<Kitchen?>(null);
RxInt selectedMenuIndex = MenuIndexState.dashboard.index.obs;
// MenuIndexState.home.index.obs;
Rx<AuthState> authState = AuthState.unauthenticated.obs;

void changePage(int index) {
  selectedMenuIndex.value = index;
}
