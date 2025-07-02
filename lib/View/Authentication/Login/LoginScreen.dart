import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Reusable%20Widgets/RoundedButton.dart';
import 'package:project_x/Resources/Reusable%20Widgets/Sizing%20of%20Screen.dart';
import 'package:project_x/Resources/Reusable%20Widgets/TextInputForm/TextInputForm.dart';
import 'package:project_x/Utils/Utils.dart';
import 'package:project_x/View/Dashboard/DashboardScreen.dart';
import '../../../View_model/Controllers/LoginController.dart';
import 'Widgets/LoginAllInfo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

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
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: SizingConfig.height(0.02)),
              /// All other information etc (textforms Fields & Button)
              LoginAllInfo(formKey: _formKey, controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

