

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController{

  Rx<bool> loading = false.obs;

  ///controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  /// FocusNode
 final emailFocusNode = FocusNode();
 final phoneFocusNode = FocusNode();


 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
  }



}