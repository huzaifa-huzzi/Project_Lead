import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {

  // For animtions..
  var total = 128.obs;
  var daily = 24.obs;
  var weekly = 84.obs;
  var monthly = 300.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // For the graphs
  var selectedTab = 0.obs; // for the tabulars





}