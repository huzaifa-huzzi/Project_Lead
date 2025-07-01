import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Resources/Colors/Colors.dart';

class Utils {

  // Focus for textFormField;
  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  // Success Toast
  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.successColor,
      textColor: AppColors.surfaceColor,
      gravity: ToastGravity.BOTTOM,
    );
  }


  // Error Snackbar
  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.surfaceColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }




}