import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final countryController = TextEditingController();
  final suburbController = TextEditingController();
  final stateController = TextEditingController();
  final websiteController = TextEditingController();
  final keywordTitleController = TextEditingController();
  final statusController = TextEditingController(text: 'Open');
  final phoneTypeController = ''.obs;
  final keywordCategory = ''.obs;
  final cityController = ''.obs;
  final selectedSuburb = ''.obs;
  Rx<bool> loading = false.obs;

  /// Focus Nodes
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final zipcodeFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final suburbFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final websiteFocusNode = FocusNode();
  final keywordTitleFocusNode = FocusNode();

  /// Strings
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

  final List<String> states = [
    'New South Wales',
    'Victoria',
    'Queensland',
    'South Australia'
  ];

  final List<String> cities = [
    'Lahore',
    'Karachi',
    'Islamabad'
  ];

  final List<String> categories = [
    'Hospitality',
    'Construction'
  ];

  final List<String> phoneTypes = [
    'Personal',
    'Business'
  ];

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
    keywordTitleController.dispose();
    statusController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    addressFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    zipcodeFocusNode.dispose();
    countryFocusNode.dispose();
    suburbFocusNode.dispose();
    stateFocusNode.dispose();
    websiteFocusNode.dispose();
    keywordTitleFocusNode.dispose();

    super.onClose();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    addressController.clear();
    phoneNumberController.clear();
    zipcodeController.clear();
    countryController.clear();
    suburbController.clear();
    stateController.clear();
    websiteController.clear();
    keywordTitleController.clear();
    statusController.clear();
    phoneTypeController.value = '';
    keywordCategory.value = '';
    cityController.value = '';
    selectedSuburb.value = '';
  }
}