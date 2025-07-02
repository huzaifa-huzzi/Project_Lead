import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project_x/Resources/Reusable%20Widgets/PrimartBtn.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../View_model/Controllers/FormController.dart';
import '../../Resources/Colors/Colors.dart';

class FormFilling extends StatefulWidget {
  const FormFilling({super.key});

  @override
  State<FormFilling> createState() => _FormFillingState();
}

class _FormFillingState extends State<FormFilling> {
  final _formKey = GlobalKey<FormState>();
  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    SizingConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Personal Information",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.04)),
                      Wrap(
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
                      ),

                       SizedBox(height: SizingConfig.height(0.02)),
                      const Text("Contact Details",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.02)),
                      Wrap(
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
                      ),

                       SizedBox(height:SizingConfig.height(0.02)),
                      const Text("Location Info",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.02)),
                      Wrap(
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
                      ),

                       SizedBox(height: SizingConfig.height(0.02)),
                      Obx(() => Center(
                        child: PrimaryBtn(
                          title: 'Submit',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              print('Form submitted successfully');
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
        ),
      ),
    );
  }
}
