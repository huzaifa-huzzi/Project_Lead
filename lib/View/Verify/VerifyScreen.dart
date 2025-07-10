import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/Resources/Reusable%20Widgets/TextInputForm/TextInputForm.dart';
import 'package:project_x/View_model/Controllers/VerificationController.dart';
import '../../Resources/Reusable Widgets/PrimartBtn.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final VerificationController controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.screenColors,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth < 600 ? screenWidth * 0.9 : 500,
              ),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header
                        Row(
                          children: [
                            const Icon(Icons.verified_user, size: 20),
                            SizedBox(width: SizingConfig.width(0.01)),
                            const Text(
                              "Verification",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: SizingConfig.height(0.04)),

                        /// Email Field
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextInputForm(
                          myController: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Email',
                          iconData: Icons.email_outlined,
                          onValidator: (value) =>
                          value!.isEmpty ? 'Enter email' : null,
                        ),
                        SizedBox(height: SizingConfig.height(0.04)),

                        /// Phone Number Field
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextInputForm(
                          myController: controller.phoneController,
                          focusNode: controller.phoneFocusNode,
                          onFieldSubmittedView: (_) {},
                          keyBoardType: TextInputType.phone,
                          hint: 'Phone Number',
                          iconData: Icons.phone,
                          onValidator: (value) =>
                          value!.isEmpty ? 'Enter phone number' : null,
                        ),
                        SizedBox(height: SizingConfig.height(0.05)),

                        /// Button
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: PrimaryBtn(
                              title: 'Verify',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Verification form submitted');
                                }
                              },
                              loading: controller.loading.value,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
