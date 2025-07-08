// lib/controller/dashboard_controller.dart
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var isSidebarCollapsed = false.obs;

  void toggleSidebar() {
    isSidebarCollapsed.value = !isSidebarCollapsed.value;
  }

  void changeScreen(int index) {
    selectedIndex.value = index;
  }
}
