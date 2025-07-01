import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final countryController = TextEditingController();

   // loading
  Rx<bool> loading = false.obs;

  // focusNodes
  final nameFocusNode = FocusNode();
  final emailFocusNode= FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final zipcodeFocusNode= FocusNode();
  final countryFocusNode = FocusNode();




}