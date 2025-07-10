import 'package:get/get.dart';
import 'package:project_x/Routes/Routes_name.dart';
import 'package:project_x/View/Authentication/Login/LoginScreen.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';
import 'package:project_x/View/Form/Form.dart';
import 'package:project_x/View/Home/HomeScreen.dart';
import 'package:project_x/View/Verify/VerifyScreen.dart';

class AppRoutes {
  
  static appRoutes () => [
    /// Authentication
    GetPage(name:RouteName.loginScreen , page: () => const LoginScreen()),
    /// Screens
    GetPage(name:RouteName.dashboardScreen , page: () =>  DashboardScreen()),
    GetPage(name:RouteName.homeScreen , page: () =>  HomeScreen()),
    GetPage(name:RouteName.formsFillingScreen , page: () =>  FormFilling()),
    GetPage(name:RouteName.verifyScreen , page: () =>  VerifyScreen()),
  ];
  
  
}