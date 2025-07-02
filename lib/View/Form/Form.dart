import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project_x/Resources/Reusable%20Widgets/PrimartBtn.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../View_model/Controllers/FormController.dart';

class FormFilling extends StatefulWidget {
  const FormFilling({super.key});

  @override
  State<FormFilling> createState() => _FormFillingState();
}

class _FormFillingState extends State<FormFilling> {
  final _formKey = GlobalKey<FormState>();
  final FormController controller = Get.put(FormController());

  ///  Automatically switches layout for mobile/web
  Widget buildFormRow(Widget firstField, Widget secondField) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    SizingConfig.init(context);

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            firstField,
             SizedBox(height: SizingConfig.height(0.02)),
            secondField,
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            Expanded(child: firstField),
             SizedBox(width: SizingConfig.width(0.02)),
            Expanded(child: secondField),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildFormRow(
                    TextInputForm(
                      myController: controller.nameController,
                      focusNode: controller.nameFocusNode,
                      onFieldSubmittedView: (_) {},
                      keyBoardType: TextInputType.text,
                      hint: 'Name',
                      iconData: Icons.person_outline,
                      onValidator: (value) =>
                      value!.isEmpty ? 'Please enter name' : null,
                    ),
                    TextInputForm(
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
                  buildFormRow(
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                    Obx(() => DropdownButtonFormField<String>(
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
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select phone type'
                          : null,
                      onChanged: (value) {
                        controller.phoneTypeController.value = value!;
                      },
                    )),
                  ),
                  buildFormRow(
                    TextInputForm(
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
                    TextInputForm(
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
                  buildFormRow(
                    Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedSuburb.value.isEmpty
                          ? null
                          : controller.selectedSuburb.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined),
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
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please select a suburb'
                          : null,
                      onChanged: (value) {
                        controller.selectedSuburb.value = value!;
                      },
                    )),
                    TextInputForm(
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
                  buildFormRow(
                    TextInputForm(
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
                    TextInputForm(
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
                  Obx(() => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PrimaryBtn(
                      title: 'Submit',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('submit');
                        }
                      },
                      loading: controller.loading.value,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
