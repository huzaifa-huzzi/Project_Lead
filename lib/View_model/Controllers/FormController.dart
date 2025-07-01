import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final countryController = TextEditingController();
  final suburbController = TextEditingController();
  final stateController = TextEditingController();

   // loading
  Rx<bool> loading = false.obs;

  // focusNodes
  final nameFocusNode = FocusNode();
  final emailFocusNode= FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final zipcodeFocusNode= FocusNode();
  final countryFocusNode = FocusNode();
  final suburbFocusNode= FocusNode();
  final stateFocusNode = FocusNode();

  // Dropdown for the suburbs
  var selectedSuburb = ''.obs;

  final List<String> suburbs = [
    'Sydney',
    'Melbourne',
    'South Yarra',
    'Paddington',
    'Toorak',
    'Cremorne Point',
    'Woolwich',
    'Mosman',
    'North Sydney'
  ];





}