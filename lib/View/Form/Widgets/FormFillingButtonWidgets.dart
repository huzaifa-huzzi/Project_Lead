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
  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Obx(() => isMobile
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryBtn(
          title: 'Submit',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              print('Form submitted successfully');
            }
          },
          loading: controller.loading.value,
          color: AppColors.primaryColor,
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: SizingConfig.width(0.02)),
        SizedBox(
          width: SizingConfig.width(0.15),
          child: PrimaryBtn(
            title: 'Submit',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                print('Form submitted successfully');
              }
            },
            loading: controller.loading.value,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    ));
  }

}

