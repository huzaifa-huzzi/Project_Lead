import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../../Resources/Reusable Widgets/PrimartBtn.dart';
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

    return Scaffold(
      backgroundColor: AppColors.screenColors,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Card(
              elevation: 5,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double maxWidth = constraints.maxWidth;
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              const Icon(FeatherIcons.key, size: 20),
                              SizedBox(width: SizingConfig.width(0.02)),
                              const Text(
                                "Form",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: SizingConfig.height(0.05)),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "Category",
                            child1: Obx(() => DropdownButtonFormField<String>(
                              value: controller.keywordCategory.value.isEmpty
                                  ? null
                                  : controller.keywordCategory.value,
                              decoration:
                              _inputDecoration("Select Category", Icons.category_outlined),
                              items: controller.categories
                                  .map((item) =>
                                  DropdownMenuItem(value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (value) =>
                              controller.keywordCategory.value = value!,
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Select category' : null,
                            )),
                            label2: "Title",
                            child2: TextInputForm(
                              myController: controller.keywordTitleController,
                              hint: 'Title',
                              iconData: Icons.title,
                              focusNode: controller.keywordTitleFocusNode,
                              keyBoardType: TextInputType.text,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) =>
                              value!.isEmpty ? 'Enter title' : null,
                            ),
                          ),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "Name",
                            child1: TextInputForm(
                              myController: controller.nameController,
                              hint: 'Name',
                              iconData: Icons.person,
                              focusNode: controller.nameFocusNode,
                              keyBoardType: TextInputType.name,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter name' : null,
                            ),
                            label2: "Email",
                            child2: TextInputForm(
                              myController: controller.emailController,
                              hint: 'Email',
                              iconData: Icons.email_outlined,
                              focusNode: controller.emailFocusNode,
                              keyBoardType: TextInputType.emailAddress,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter email' : null,
                            ),
                          ),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "Phone Number",
                            child1: TextInputForm(
                              myController: controller.phoneNumberController,
                              hint: 'Phone Number',
                              iconData: Icons.phone,
                              focusNode: controller.phoneNumberFocusNode,
                              keyBoardType: TextInputType.phone,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter phone' : null,
                            ),
                            label2: "Phone Type",
                            child2: Obx(() => DropdownButtonFormField<String>(
                              value: controller.phoneTypeController.value.isEmpty
                                  ? null
                                  : controller.phoneTypeController.value,
                              decoration: _inputDecoration("Select Phone Type", Icons.phone_android),
                              items: controller.phoneTypes
                                  .map((item) =>
                                  DropdownMenuItem(value: item, child: Text(item)))
                                  .toList(),
                              onChanged: (value) =>
                              controller.phoneTypeController.value = value!,
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Select phone type' : null,
                            )),
                          ),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "Website",
                            child1: TextInputForm(
                              myController: controller.websiteController,
                              hint: 'Website',
                              iconData: Icons.web,
                              focusNode: controller.websiteFocusNode,
                              keyBoardType: TextInputType.url,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter website' : null,
                            ),
                            label2: "Zip Code",
                            child2: TextInputForm(
                              myController: controller.zipcodeController,
                              hint: 'Zip Code',
                              iconData: Icons.home,
                              focusNode: controller.zipcodeFocusNode,
                              keyBoardType: TextInputType.number,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter zip code' : null,
                            ),
                          ),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "Suburb",
                            child1: TextInputForm(
                              myController: controller.suburbController,
                              hint: 'Suburb',
                              iconData: Icons.location_city,
                              focusNode: controller.suburbFocusNode,
                              keyBoardType: TextInputType.text,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter suburb' : null,
                            ),
                            label2: "City",
                            child2: Obx(() => DropdownButtonFormField<String>(
                              value: controller.cityController.value.isEmpty
                                  ? null
                                  : controller.cityController.value,
                              decoration: _inputDecoration("Select City", Icons.location_city_outlined),
                              items: controller.cities
                                  .map((city) =>
                                  DropdownMenuItem(value: city, child: Text(city)))
                                  .toList(),
                              onChanged: (value) =>
                              controller.cityController.value = value!,
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Select city' : null,
                            )),
                          ),

                          buildResponsiveRow(
                            maxWidth: maxWidth,
                            label1: "State",
                            child1: Obx(() => DropdownButtonFormField<String>(
                              value: controller.selectedSuburb.value.isEmpty
                                  ? null
                                  : controller.selectedSuburb.value,
                              decoration: _inputDecoration("Select State", Icons.map_outlined),
                              items: controller.suburbs
                                  .map((state) =>
                                  DropdownMenuItem(value: state, child: Text(state)))
                                  .toList(),
                              onChanged: (value) =>
                              controller.selectedSuburb.value = value!,
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Select state' : null,
                            )),
                            label2: "",
                            child2: const SizedBox(), // Empty field for spacing
                          ),

                          buildField("Complete Address",
                            child: TextInputForm(
                              myController: controller.addressController,
                              hint: 'Address',
                              iconData: Icons.location_on_outlined,
                              focusNode: controller.addressFocusNode,
                              keyBoardType: TextInputType.text,
                              onFieldSubmittedView: (_) {},
                              onValidator: (value) => value!.isEmpty ? 'Enter address' : null,
                            ),
                          ),

                          SizedBox(height: SizingConfig.height(0.02)),
                          Center(
                            child: PrimaryBtn(
                              title: 'Submit',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Form submitted');
                                }
                              },
                              loading: controller.loading.value,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, {required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          if (label.isNotEmpty) const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget buildResponsiveRow({
    required double maxWidth,
    required String label1,
    required Widget child1,
    required String label2,
    required Widget child2,
  }) {
    if (maxWidth < 600) {
      return Column(
        children: [
          buildField(label1, child: child1),
          buildField(label2, child: child2),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: buildField(label1, child: child1)),
          const SizedBox(width: 20),
          Expanded(child: buildField(label2, child: child2)),
        ],
      );
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIcon: Icon(icon),
    );
  }
}
