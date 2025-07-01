import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Resources/Reusable Widgets/RoundedButton.dart';
import '../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../View_model/Controllers/FormController.dart';
import '../Dashboard/DashboardScreen.dart';


class FormFilling extends StatefulWidget {
  const FormFilling({super.key});

  @override
  State<FormFilling> createState() => _FormFillingState();
}

class _FormFillingState extends State<FormFilling> {
  final _formKey = GlobalKey<FormState>();
  final FormController controller = Get.put(FormController());

  Widget buildFormRow(Widget firstField, Widget secondField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(child: firstField),
          const SizedBox(width: 16),
          Expanded(child: secondField),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormRow(
                TextInputForm(
                  myController: controller.nameController,
                  focusNode: controller.nameFocusNode,
                  onFieldSubmittedView: (value) {
                    // Utils.fieldFocusChange(context, controller.usernameFocus, controller.emailFocus);
                  },
                  keyBoardType: TextInputType.text,
                  hint: 'Organization name',
                  iconData: Icons.person_outline,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                TextInputForm(
                  myController: controller.emailController,
                  focusNode: controller.emailFocusNode,
                  onFieldSubmittedView: (value) {
                   // Utils.fieldFocusChange(context, controller.emailFocus, controller.phoneFocus);
                  },
                  keyBoardType: TextInputType.emailAddress,
                  hint: 'Email',
                  iconData: Icons.email_outlined,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              buildFormRow(
                TextInputForm(
                  myController: controller.phoneNumberController,
                  focusNode: controller.phoneNumberFocusNode,
                  onFieldSubmittedView: (value) {
                   // Utils.fieldFocusChange(context, controller.phoneFocus, controller.cityFocus);
                  },
                  keyBoardType: TextInputType.phone,
                  hint: 'Phone',
                  iconData: Icons.phone_outlined,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                TextInputForm(
                  myController: controller.addressController,
                  focusNode: controller.addressFocusNode,
                  onFieldSubmittedView: (value) {
                    //Utils.fieldFocusChange(context, controller.cityFocus, controller.addressFocus);
                  },
                  keyBoardType: TextInputType.text,
                  hint: 'Address',
                  iconData: Icons.location_city_outlined,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
              ),
              buildFormRow(
                TextInputForm(
                  myController: controller.zipcodeController,
                  focusNode: controller.zipcodeFocusNode,
                  onFieldSubmittedView: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  keyBoardType: TextInputType.text,
                  hint: 'zip Code',
                  iconData: Icons.home_outlined,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                TextInputForm(
                  myController: controller.countryController,
                  focusNode: controller.countryFocusNode,
                  onFieldSubmittedView: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  keyBoardType: TextInputType.number,
                  hint: 'Country',
                  iconData: Icons.local_post_office_outlined,
                  onValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter zip code';
                    }
                    return null;
                  },
                ),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: RoundedButton(
                  title: 'Login',
                  loading: controller.loading.value,
                  onTap: () {
                   print('submitted');
                    }
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
