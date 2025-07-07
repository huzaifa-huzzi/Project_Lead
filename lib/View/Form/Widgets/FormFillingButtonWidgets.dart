import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../../Resources/Reusable Widgets/PrimartBtn.dart';
import '../../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../../View_model/Controllers/FormController.dart';

class FormFillingButtonWidget extends StatelessWidget {
  const FormFillingButtonWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.controller,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final FormController controller;

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///  Clear Button
        PrimaryBtn(
          title: 'Clear',
          onTap: () {
              _formKey.currentState?.reset();
              controller.clearForm();
          },
          loading: controller.loading.value,
          color: Color(0xff515a65),
        ),

         SizedBox(width: SizingConfig.width(0.02)),

        ///  Submit Button
        PrimaryBtn(
          title: 'Submit',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              print('Form submitted successfully');
              // Logic
            }
          },
          loading: controller.loading.value, color: AppColors.primaryColor,
        ),
      ],
    ));
  }
}

