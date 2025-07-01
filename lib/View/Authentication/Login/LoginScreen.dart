import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Reusable%20Widgets/RoundedButton.dart';
import 'package:project_x/Resources/Reusable%20Widgets/Sizing%20of%20Screen.dart';
import 'package:project_x/Resources/Reusable%20Widgets/TextInputForm/TextInputForm.dart';
import 'package:project_x/Utils/Utils.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';
import '../../../View_model/Controllers/LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    controller.usernameController.dispose();
    controller.passwordController.dispose();
    controller.usernameFocus.dispose();
    controller.passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 👤 Icon
              Icon(Icons.lock_outline, size: 80, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 40),

              Form(
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
                          Utils.fieldFocusChange(context, controller.usernameFocus, controller.passwordFocus);
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
                          Utils.fieldFocusChange(context, controller.passwordFocus, controller.usernameFocus);
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
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                        child: RoundedButton(
                          title: 'Login',
                          loading: controller.loading.value,
                          onTap: () {
                            controller.loading.value = true;
                            Get.to(DashboardScreen());
                            controller.loading.value = false;
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
