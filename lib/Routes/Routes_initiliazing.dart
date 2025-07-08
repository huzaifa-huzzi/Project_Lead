import 'package:get/get.dart';
import 'package:project_x/Routes/Routes_name.dart';
import 'package:project_x/View/Authentication/Login/LoginScreen.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';

class AppRoutes {
  
  static appRoutes () => [
    GetPage(name:RouteName.loginScreen , page: () => const LoginScreen()),
    GetPage(name:RouteName.dashboardScreen , page: () =>  DashboardScreen()),
  ];
  
  
}