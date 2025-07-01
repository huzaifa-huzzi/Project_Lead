


import 'package:get/get.dart';
import 'package:project_x/Routes/Routes_name.dart';
import 'package:project_x/View/Authentication/Login/LoginScreen.dart';

class AppRoutes {
  
  static appRoutes () => [
    GetPage(name:RouteName.loginScreen , page: () => const LoginScreen()),
  ];
  
  
}