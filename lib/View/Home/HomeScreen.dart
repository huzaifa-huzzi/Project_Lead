import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/HomeController..dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.screenColors,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizingConfig.width(0.06),
          vertical: SizingConfig.height(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const Spacer(),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.07)),

            /// Headings + Animated Numbers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildAnimatedStat("Total", controller.total.value)),
                Obx(() => _buildAnimatedStat("Daily", controller.daily.value)),
                Obx(() => _buildAnimatedStat("Weekly", controller.weekly.value)),
                Obx(() => _buildAnimatedStat("Monthly", controller.monthly.value)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Title + Animated Count
  Widget _buildAnimatedStat(String title, int targetValue) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: targetValue),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Text(
              value.toString(),
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }
}
