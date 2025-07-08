import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Resources/Colors/Colors.dart';

class Utils {

  // Focus for textFormField;
  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


// success Snackbar
  static void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: AppColors.surfaceColor,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
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