import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/HomeController..dart';
import 'package:fl_chart/fl_chart.dart';

/// Widgets not done

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
            /// Header
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

            SizedBox(height: SizingConfig.height(0.1)),

            /// Stat Cards
            Text(
              "Forms Submitted",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: SizingConfig.height(0.03)),
            Wrap(
              spacing: 30,
              runSpacing: 16,
              children: [
                Obx(() => _buildAnimatedStat("Total", controller.total.value)),
                Obx(() => _buildAnimatedStat("Today", controller.daily.value)),
                Obx(() => _buildAnimatedStat("Weekly", controller.weekly.value)),
                Obx(() => _buildAnimatedStat("Monthly", controller.monthly.value)),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.1)),

            /// Toggle Buttons
            Text(
              "Analysis Charts",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: SizingConfig.height(0.03)),
            Row(
              children: [
                Expanded(child: _buildToggleButton("Day", 0)),
                const SizedBox(width: 12),
                Expanded(child: _buildToggleButton("Week", 1)),
                const SizedBox(width: 12),
                Expanded(child: _buildToggleButton("Month", 2)),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.1)),

            /// Conditional Chart
            Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return DayChart();
                case 1:
                  return WeekChart();
                case 2:
                  return MonthChart();
                default:
                  return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStat(String title, int targetValue) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
           SizedBox(height: SizingConfig.height(0.03)),
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
      ),
    );
  }

  Widget _buildToggleButton(String title, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectedTab.value = index;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primaryColor),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    });
  }
}

/// Day chart


class DayChart extends StatelessWidget {
  final double barValue = 12;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 120,
            child: BarChart(
              BarChartData(
                maxY: 20,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 5,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                  bottomTitles: AxisTitles(),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: 5,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 2,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: barValue,
                        width: 30,
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                          colors: [Colors.teal, Colors.lightBlueAccent],
                        ),
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),

          /// Positioned value above bar
          Positioned(
            top: _calculateTopPosition(barValue),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75), // Tooltip background
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$barValue',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTopPosition(double value) {
    // Adjust this multiplier based on maxY and widget height
    double chartHeight = 250;
    double maxY = 20;
    double paddingTop = 30;

    return (chartHeight - (value / maxY * chartHeight)) - 40 + paddingTop;
  }
}


/// Week Chart
class WeekChart extends StatelessWidget {
  final List<double> values = [12, 18, 14, 10, 16, 12, 8];
  final List<String> labels = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          maxY: 25,
          barTouchData: BarTouchData(enabled: true),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.grey, width: 1),
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, _) => Text('${value.toInt()}'),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return Text(
                      labels[index],
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          barGroups: List.generate(values.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index],
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Colors.lightBlueAccent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}


/// Month chart
class MonthChart extends StatelessWidget {
  final List<double> values = [60, 85, 70, 90];
  final List<String> labels = ['W1', 'W2', 'W3', 'W4'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.grey, width: 1),
              bottom: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, _) => Text('${value.toInt()}'),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return Text(labels[index]);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          barGroups: List.generate(values.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: values[index],
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Colors.lightBlueAccent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}




