import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

   /// Logic for the change of the screen
  void changeScreen(int index) {
    selectedIndex.value = index;
  }
}
