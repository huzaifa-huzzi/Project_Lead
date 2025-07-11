import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/Resources/Reusable%20Widgets/PrimartBtn.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';
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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Email Label
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),

            /// Email Field
            TextInputForm(
              myController: controller.emailController,
              focusNode: controller.emailFocus,
              hint: 'Enter your email',
              iconData: Icons.email_outlined,
              keyBoardType: TextInputType.emailAddress,
              onFieldSubmittedView: (value) {
                FocusScope.of(context).requestFocus(controller.passwordFocus);
              },
              onValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            /// Password Label
            const Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),

            /// Password Field
            TextInputForm(
              myController: controller.passwordController,
              focusNode: controller.passwordFocus,
              hint: 'Enter your password',
              iconData: Icons.lock_outline,
              keyBoardType: TextInputType.visiblePassword,
              onFieldSubmittedView: (value) {
                FocusScope.of(context).unfocus();
              },
              onValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            /// Login Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 37),
              child: PrimaryBtn(title: 'Login', onTap: (){
                Get.to(() => DashboardScreen());
              }, loading:controller.loading.value, color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}