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
              margin: EdgeInsets.symmetric(
                horizontal: SizingConfig.width(0.02),
                vertical: SizingConfig.height(0.03),
              ),
              padding: EdgeInsets.all(SizingConfig.width(0.02)),
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
                  ///  Left Side Image
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(SizingConfig.width(0.02)),
                      child: Image.asset(
                        'assets/images/login-pic.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  ///  Right Side Form
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.03)),
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
                          SizedBox(height: SizingConfig.height(0.005)),
                          const Text(
                            "Login your account",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: SizingConfig.height(0.025)),
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
                    /// Left side of Image for Mobile
                    Padding(
                      padding: EdgeInsets.only(bottom: SizingConfig.height(0.02)),
                      child: Image.asset(
                        'assets/images/login-pic.png',
                        height: SizingConfig.height(0.22),
                      ),
                    ),
                    const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: SizingConfig.height(0.005)),
                    const Text("Login your account", style: TextStyle(fontSize: 14)),
                    SizedBox(height: SizingConfig.height(0.025)),

                    /// Login Form
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.05)),
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
