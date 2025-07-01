

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<bool> loading = false.obs;

  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();



}