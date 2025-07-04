import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Resources/Reusable Widgets/RoundedButton.dart';
import '../../../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../../../Resources/Reusable Widgets/TextInputForm/TextInputForm.dart';
import '../../../../Utils/Utils.dart';
import '../../../../View_model/Controllers/LoginController.dart';
import '../../../Dashboard/DashboardScreen.dart';




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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextInputForm(
              myController: controller.usernameController,
              focusNode: controller.usernameFocus,
              onFieldSubmittedView: (value) {
                Utils.fieldFocusChange(
                  context,
                  controller.usernameFocus,
                  controller.passwordFocus,
                );
              },
              keyBoardType: TextInputType.text,
              hint: 'Username',
              iconData: Icons.person_outline,
              onValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter username';
                }
                return null;
              },
            ),
            SizedBox(height: SizingConfig.height(0.02)),
            TextInputForm(
              myController: controller.passwordController,
              focusNode: controller.passwordFocus,
              onFieldSubmittedView: (value) {
                Utils.fieldFocusChange(
                  context,
                  controller.passwordFocus,
                  controller.usernameFocus,
                );
              },
              keyBoardType: TextInputType.text,
              hint: 'Password',
              iconData: Icons.lock_outline,
              onValidator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
            ),
            SizedBox(height: SizingConfig.height(0.1)),

            /// Login Button
            Obx(
                  () => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: RoundedButton(
                  title: 'Login',
                  loading: controller.loading.value,
                  onTap: () {
                    controller.loading.value = true;
                    Get.to(DashboardScreen());
                    controller.loading.value = false;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
