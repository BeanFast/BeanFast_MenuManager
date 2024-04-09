import 'package:get/get.dart';

import '../enums/menu_index_enum.dart';
import '/enums/auth_state_enum.dart';
import '/models/user.dart';

Map<String, int> rowSize = {'5': 5, '10': 10, '15': 15, '20': 20};

Rx<User> currentUser = User().obs;
RxInt selectedMenuIndex = MenuIndexState.dashboard.index.obs;
// MenuIndexState.home.index.obs;
Rx<AuthState> authState = AuthState.unauthenticated.obs;

void changePage(int index) {
  selectedMenuIndex.value = index;
}
