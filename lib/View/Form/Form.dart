import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:project_x/View/Form/Widgets/FormFillingButtonWidgets.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../Resources/Colors/Colors.dart';
import '../../View_model/Controllers/FormController.dart';

class FormFilling extends StatelessWidget {
  FormFilling({super.key});

  final _formKey = GlobalKey<FormState>();
  final FormController controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title & Icon
                       Row(
                         children: [
                           Icon(
                             FeatherIcons.key,
                             size: 24,
                           ),
                           SizedBox(width: SizingConfig.width(0.03)),
                           Text(
                             "Form",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 24,
                             ),
                           ),
                         ],
                       ),


                      SizedBox(height: SizingConfig.height(0.03)),

                      /// Personal Information
                      sectionTitle("Personal Information",),
                      SizedBox(height: SizingConfig.height(0.03)),
                      buildWrap([
                        TextInputForm(
                          myController: controller.nameController,
                          focusNode: controller.nameFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.name,
                          hint: 'Name',
                          iconData: Icons.person_outline,
                          onValidator: (value) => value!.isEmpty ? 'Please enter name' : null,
                        ),
                        TextInputForm(
                          myController: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Email',
                          iconData: Icons.email_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter email' : null,
                        ),
                      ], isMobile),

                      SizedBox(height: SizingConfig.height(0.03)),

                      /// Contact Information
                      sectionTitle("Contact Information"),
                      SizedBox(height: SizingConfig.height(0.03)),
                      buildWrap([
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'AU',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        Obx(() => DropdownButtonFormField<String>(
                          value: controller.phoneTypeController.value.isEmpty
                              ? null
                              : controller.phoneTypeController.value,
                          decoration: InputDecoration(
                            labelText: 'Phone Type',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(Icons.phone_android),
                          ),
                          items: ['Personal', 'Business'].map((type) {
                            return DropdownMenuItem(value: type, child: Text(type));
                          }).toList(),
                          onChanged: (value) => controller.phoneTypeController.value = value!,
                          validator: (value) => value == null || value.isEmpty ? 'Select phone type' : null,
                        )),
                        TextInputForm(
                          myController: controller.websiteController,
                          focusNode: controller.websiteFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.url,
                          hint: 'Website',
                          iconData: Icons.web_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter website' : null,
                        ),
                        TextInputForm(
                          myController: controller.addressController,
                          focusNode: controller.addressFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.text,
                          hint: 'Address',
                          iconData: Icons.location_city_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter address' : null,
                        ),
                      ], isMobile),

                      SizedBox(height: SizingConfig.height(0.03)),

                      /// Location Information
                      sectionTitle("Location Information"),
                      SizedBox(height: SizingConfig.height(0.01)),
                      buildWrap([
                        Obx(() {
                          final selected = controller.selectedSuburb.value;


                          final isValid = controller.suburbs.contains(selected);
                          final dropdownValue = isValid ? selected : null;

                          return DropdownButtonFormField<String>(
                            value: dropdownValue,
                            decoration: InputDecoration(
                              labelText: 'Select Suburb',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: const Icon(Icons.location_on_outlined),
                            ),
                            items: controller.suburbs.toSet().map((suburb) {
                              return DropdownMenuItem<String>(
                                value: suburb,
                                child: Text(suburb),
                              );
                            }).toList(),
                            onChanged: (value) => controller.selectedSuburb.value = value!,
                            validator: (value) => value == null || value.isEmpty ? 'Select suburb' : null,
                          );
                        }),

                        TextInputForm(
                          myController: controller.stateController,
                          focusNode: controller.stateFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.text,
                          hint: 'State',
                          iconData: Icons.map_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter state' : null,
                        ),
                        TextInputForm(
                          myController: controller.countryController,
                          focusNode: controller.countryFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.text,
                          hint: 'Country',
                          iconData: Icons.flag_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter country' : null,
                        ),
                        TextInputForm(
                          myController: controller.zipcodeController,
                          focusNode: controller.zipcodeFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.number,
                          hint: 'Zip Code',
                          iconData: Icons.home_outlined,
                          onValidator: (value) => value!.isEmpty ? 'Please enter zip code' : null,
                        ),
                      ], isMobile),

                      SizedBox(height: SizingConfig.height(0.04)),

                      /// Submit Button
                      FormFillingButtonWidget(formKey: _formKey, controller: controller)
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

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildWrap(List<Widget> children, bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: children.map((e) => SizedBox(width: isMobile ? double.infinity : 350, child: e)).toList(),
    );
  }
}
