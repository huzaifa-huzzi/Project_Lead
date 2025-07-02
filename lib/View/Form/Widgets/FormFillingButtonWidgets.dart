import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Resources/Reusable Widgets/PrimartBtn.dart';
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
    return Obx(() => Center(
      child: PrimaryBtn(
        title: 'Submit',
        onTap: () {
          if (_formKey.currentState!.validate()) {
            print('Form submitted successfully');
          }
        },
        loading: controller.loading.value,
      ),
    ));
  }
}
