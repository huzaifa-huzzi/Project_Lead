import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_x/Resources/Colors/Colors.dart';

class HomeController extends GetxController {
  RxString selectedRange = 'Day'.obs;
  RxDouble maxY = 10.0.obs;
  RxList<BarChartGroupData> barData = <BarChartGroupData>[].obs;

  final Map<String, List<double>> dummyData = {
    'Day': [0, 6.5, 8.3, 7.2, 8.0, 1.3, 0],
    'Week': [15, 25, 20, 18],
    'Month': [40, 70, 55, 90, 60, 20]
  };

  @override
  void onInit() {
    super.onInit();
    updateChart('Day');
  }



  /// Called when dropdown is changed
  void updateChart(String range) {
    selectedRange.value = range;

    final values = dummyData[range]!;
    maxY.value = values.reduce((a, b) => a > b ? a : b) + 10;

    barData.value = List.generate(values.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: values[i],
            color: AppColors.primaryColor,
            width: 16,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });
  }

  /// Get title below each bar
  String getBottomTitle(int index) {
    switch (selectedRange.value) {
      case 'Day':
        const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
        return days[index];
      case 'Week':
        return 'W${index + 1}';
      case 'Month':
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
        return months[index];
      default:
        return '';
    }
  }

  ///  Bar data for chart
  List<BarChartGroupData> getBarData() => barData;
}
