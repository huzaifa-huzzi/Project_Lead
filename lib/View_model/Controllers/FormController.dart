import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final countryController = TextEditingController();
  final suburbController = TextEditingController();
  final stateController = TextEditingController();
  final websiteController = TextEditingController();
  final phoneTypeController = ''.obs;

  /// Loading indicator
  Rx<bool> loading = false.obs;

  /// FocusNodes
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final zipcodeFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final suburbFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final websiteFocusNode = FocusNode();

  /// Dropdown for the suburbs
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

  /// Dispose all controllers and focus nodes
  @override
  void onClose() {

    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    zipcodeController.dispose();
    countryController.dispose();
    suburbController.dispose();
    stateController.dispose();
    websiteController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    addressFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    zipcodeFocusNode.dispose();
    countryFocusNode.dispose();
    suburbFocusNode.dispose();
    stateFocusNode.dispose();
    websiteFocusNode.dispose();

    super.onClose();
  }
}
