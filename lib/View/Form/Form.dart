import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../View_model/Controllers/FormController.dart';
import '../../Resources/Colors/Colors.dart';
import 'Widgets/FormContactInfoWidget.dart';
import 'Widgets/FormFillingButtonWidgets.dart';
import 'Widgets/FormLocationInfoWidget.dart';
import 'Widgets/FormPersonalInformationWidget.dart';


//  have to make the widgets of this screen now
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
                      /// Personal information
                      const Text("Personal Information",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.04)),
                      FormPersonalInformationWidget(isMobile: isMobile, controller: controller),

                       /// contact info
                       SizedBox(height: SizingConfig.height(0.02)),
                      const Text("Contact Details",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.02)),
                      FormContactInfoWidget(isMobile: isMobile, controller: controller),

                       /// Location info
                       SizedBox(height:SizingConfig.height(0.02)),
                      const Text("Location Info",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       SizedBox(height:SizingConfig.height(0.02)),
                      FormLocationInfoWidget(isMobile: isMobile, controller: controller),

                       SizedBox(height: SizingConfig.height(0.02)),
                      /// Button
                      FormFillingButtonWidget(formKey: _formKey, controller: controller),
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







