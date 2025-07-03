import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../../View_model/Controllers/FormController.dart';




class FormContactInfoWidget extends StatelessWidget {
  const FormContactInfoWidget({
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
          child: IntlPhoneField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            initialCountryCode: 'AU',
            onChanged: (phone) {
              controller.phoneNumberController.text =
                  phone.completeNumber;
            },
            validator: (value) {
              if (value == null || value.number.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: Obx(() => DropdownButtonFormField<String>(
            value: controller.phoneTypeController.value.isEmpty
                ? null
                : controller.phoneTypeController.value,
            decoration: InputDecoration(
              labelText: 'Phone Type',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: const Icon(Icons.phone_android),
            ),
            items: ['Personal', 'Business'].map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            validator: (value) =>
            value == null || value.isEmpty
                ? 'Please select phone type'
                : null,
            onChanged: (value) {
              controller.phoneTypeController.value = value!;
            },
          )),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.websiteController,
            focusNode: controller.websiteFocusNode,
            onFieldSubmittedView: (_) {
              FocusScope.of(context).unfocus();
            },
            keyBoardType: TextInputType.url,
            hint: 'Website',
            iconData: Icons.web_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter website' : null,
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : 350,
          child: TextInputForm(
            myController: controller.addressController,
            focusNode: controller.addressFocusNode,
            onFieldSubmittedView: (_) {
              FocusScope.of(context).unfocus();
            },
            keyBoardType: TextInputType.text,
            hint: 'Address',
            iconData: Icons.location_city_outlined,
            onValidator: (value) =>
            value!.isEmpty ? 'Please enter address' : null,
          ),
        ),
      ],
    );
  }
}