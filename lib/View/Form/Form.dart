import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Reusable%20Widgets/PrimartBtn.dart';
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
                      onFieldSubmittedView: (value) {},
                      keyBoardType: TextInputType.text,
                      hint: 'Name',
                      iconData: Icons.person_outline,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter Name';
                        return null;
                      },
                    ),
                    TextInputForm(
                      myController: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      onFieldSubmittedView: (value) {},
                      keyBoardType: TextInputType.emailAddress,
                      hint: 'Email',
                      iconData: Icons.email_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter email';
                        return null;
                      },
                    ),
                  ),
                  buildFormRow(
                    TextInputForm(
                      myController: controller.phoneNumberController,
                      focusNode: controller.phoneNumberFocusNode,
                      onFieldSubmittedView: (value) {},
                      keyBoardType: TextInputType.phone,
                      hint: 'Phone',
                      iconData: Icons.phone_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter phone number';
                        return null;
                      },
                    ),
                    TextInputForm(
                      myController: controller.addressController,
                      focusNode: controller.addressFocusNode,
                      onFieldSubmittedView: (value) {},
                      keyBoardType: TextInputType.text,
                      hint: 'Address',
                      iconData: Icons.location_city_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter address';
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
                      hint: 'Zip Code',
                      iconData: Icons.home_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter zip code';
                        return null;
                      },
                    ),
                    TextInputForm(
                      myController: controller.countryController,
                      focusNode: controller.countryFocusNode,
                      onFieldSubmittedView: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      keyBoardType: TextInputType.text,
                      hint: 'Country',
                      iconData: Icons.flag_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter country';
                        return null;
                      },
                    ),
                  ),

                  buildFormRow(
                    Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedSuburb.value.isEmpty ? null : controller.selectedSuburb.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        hintText: 'Select Suburb',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: controller.suburbs.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a suburb';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedSuburb.value = value!;
                      },
                    )),
                    TextInputForm(
                      myController: controller.stateController,
                      focusNode: controller.stateFocusNode,
                      onFieldSubmittedView: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      keyBoardType: TextInputType.text,
                      hint: 'State',
                      iconData: Icons.map_outlined,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Please enter state';
                        return null;
                      },
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
