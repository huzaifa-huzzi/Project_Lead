import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/Resources/Reusable Widgets/Sizing of Screen.dart';
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
      backgroundColor: AppColors.sidebarTextColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isLargeScreen = constraints.maxWidth > 800;

          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.loginScreenCardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              width: isLargeScreen ? 800 : double.infinity,
              child: isLargeScreen
                  ? Row(
                children: [
                  /// 🖼 Left Side Image
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/images/login-pic.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  /// 📋 Right Side Form
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Login your account",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          LoginAllInfo(formKey: _formKey, controller: controller),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    /// Top Image for Mobile
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Image.asset(
                        'assets/images/login-pic.png',
                        height: 180,
                      ),
                    ),

                    const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text("Login your account", style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 20),

                    /// Login Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LoginAllInfo(formKey: _formKey, controller: controller),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
