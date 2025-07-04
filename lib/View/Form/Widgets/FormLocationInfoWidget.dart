import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../../View_model/Controllers/FormController.dart';



class FormLocationInfoWidget extends StatelessWidget {
  const FormLocationInfoWidget({
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
          child: Obx(() => DropdownButtonFormField<String>(
            value: controller.selectedSuburb.value.isEmpty
                ? null
                : controller.selectedSuburb.value,
            decoration: InputDecoration(
              prefixIcon:
              const Icon(Icons.location_on_outlined),
              hintText: 'Select Suburb',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            items: controller.suburbs.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) =>
            value == null || value.isEmpty
                ? 'Please select a suburb'
                : null,
            onChanged: (value) {
              controller.selectedSuburb.value = value!;
            },
          )),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.stateController,
            focusNode: controller.stateFocusNode,
            onFieldSubmittedView: (_) {
              FocusScope.of(context).unfocus();
            },
            keyBoardType: TextInputType.text,
            hint: 'State',
            iconData: Icons.map_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter state' : null,
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.countryController,
            focusNode: controller.countryFocusNode,
            onFieldSubmittedView: (_) {
              FocusScope.of(context).unfocus();
            },
            keyBoardType: TextInputType.text,
            hint: 'Country',
            iconData: Icons.flag_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter country' : null,
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.zipcodeController,
            focusNode: controller.zipcodeFocusNode,
            onFieldSubmittedView: (_) {
              FocusScope.of(context).unfocus();
            },
            keyBoardType: TextInputType.text,
            hint: 'Zip Code',
            iconData: Icons.home_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter zip code' : null,
          ),
        ),
      ],
    );
  }
}