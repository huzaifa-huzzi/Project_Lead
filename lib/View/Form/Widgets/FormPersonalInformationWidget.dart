
import 'package:flutter/material.dart';

import '../../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../../View_model/Controllers/FormController.dart';


class FormPersonalInformationWidget extends StatelessWidget {
  const FormPersonalInformationWidget({
    super.key,
    required this.isMobile,
    required this.controller,
  });

  final bool isMobile;
  final FormController controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.nameController,
            focusNode: controller.nameFocusNode,
            onFieldSubmittedView: (_) {},
            keyBoardType: TextInputType.text,
            hint: 'Name',
            iconData: Icons.person_outline,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter name' : null,
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.emailController,
            focusNode: controller.emailFocusNode,
            onFieldSubmittedView: (_) {},
            keyBoardType: TextInputType.emailAddress,
            hint: 'Email',
            iconData: Icons.email_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter email' : null,
          ),
        ),
      ],
    );
  }
}