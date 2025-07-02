import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Theme/Themes.dart';
import 'package:project_x/Routes/Routes_initiliazing.dart';
import 'package:project_x/View/Authentication/Login/LoginScreen.dart';
import 'package:project_x/View/Home/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      home: LoginScreen(),
    );
  }
}

