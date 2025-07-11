import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/Resources/Reusable Widgets/PrimartBtn.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';
import '../../../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../../../View_model/Controllers/LoginController.dart';

class LoginAllInfo extends StatelessWidget {
  const LoginAllInfo({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.controller,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);

    // Common field + button max width
    const double fieldMaxWidth = 450;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Email Label
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: SizingConfig.height(0.01)),

          /// Email Field
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fieldMaxWidth),
              child: TextInputForm(
                myController: controller.emailController,
                focusNode: controller.emailFocus,
                hint: 'Enter your email',
                iconData: Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                onFieldSubmittedView: (value) {
                  FocusScope.of(context).requestFocus(controller.passwordFocus);
                },
                onValidator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  return null;
                },
              ),
            ),
          ),

          SizedBox(height: SizingConfig.height(0.03)),

          /// Password Label
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: SizingConfig.height(0.01)),

          /// Password Field
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fieldMaxWidth),
              child: TextInputForm(
                myController: controller.passwordController,
                focusNode: controller.passwordFocus,
                hint: 'Enter your password',
                iconData: Icons.lock_outline,
                keyBoardType: TextInputType.visiblePassword,
                onFieldSubmittedView: (value) {
                  FocusScope.of(context).unfocus();
                },
                onValidator: (value) {
                  if (value!.isEmpty) return 'Please enter your password';
                  return null;
                },
              ),
            ),
          ),

          SizedBox(height: SizingConfig.height(0.06)),

          /// Login Button
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fieldMaxWidth),
              child: PrimaryBtn(
                title: 'Login',
                onTap: () {
                  Get.to(() => DashboardScreen());
                },
                loading: controller.loading.value,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
