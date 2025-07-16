import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/HomeController..dart';
import 'package:fl_chart/fl_chart.dart';


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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),

                      /// Date Selection Row
                      Obx(() => Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20, color: AppColors.primaryColor),
                          SizedBox(width: SizingConfig.width(0.01)),
                          Text(
                            DateFormat('MMMM dd, yyyy').format(controller.selectedDate.value),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textColor,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit_calendar_outlined, color: AppColors.primaryColor),
                            onPressed: () => controller.pickDate(context),
                          ),
                        ],
                      )),

                      SizedBox(height: SizingConfig.height(0.1)),

                      /// Show DayChart with form count of selected date
                      Obx(() {
                        final value = controller.getFormCountForSelectedDate().toDouble();
                        return DayChart(barValue: value);
                      }),
                    ],
                  );

                case 1:
                  return Obx(() {
                    final start = controller.selectedWeekStartDate.value;
                    final end = controller.selectedWeekDates.last;

                    final rangeText =
                        "${DateFormat('dd MMM').format(start)} - ${DateFormat('dd MMM yyyy').format(end)}";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Week Range Display
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20, color: AppColors.primaryColor),
                            SizedBox(width: SizingConfig.width(0.02)),
                            Text(
                              rangeText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.textColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit_calendar_outlined, color: AppColors.primaryColor),
                              onPressed: () => controller.pickWeekDate(context),
                            ),
                          ],
                        ),

                        /// Space before chart
                        SizedBox(height: SizingConfig.height(0.1)),

                        /// Week Chart with data and labels
                        Obx(() => WeekChart(
                          values: controller.getWeekFormCounts().map((e) => e.toDouble()).toList(),
                          labels: controller.selectedWeekDates
                              .map((d) => DateFormat('E').format(d))
                              .toList(),
                        )),
                      ],
                    );
                  });

                case 2:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => ToggleButtons(
                            isSelected: [
                              controller.isFirstHalf.value,
                              !controller.isFirstHalf.value,
                            ],
                            onPressed: (index) {
                              controller.toggleHalf(index == 0);
                            },
                            borderRadius: BorderRadius.circular(8),
                            selectedColor: Colors.white,
                            fillColor: AppColors.primaryColor,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text("Jan - Jun"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text("Jul - Dec"),
                              ),
                            ],
                          )),
                          Obx(() => Row(
                            children: [
                              Text(
                                "${controller.selectedYear.value}",
                                style: TextStyle(fontSize: 16, color: AppColors.textColor),
                              ),
                              IconButton(
                                icon: const Icon(Icons.calendar_today, size: 20, color: AppColors.primaryColor),
                                onPressed: () => controller.pickYear(context),
                              ),
                            ],
                          )),
                        ],
                      ),

                      SizedBox(height: SizingConfig.height(0.1)),

                      /// Chart with values + year
                      Obx(() {
                        final isFirstHalf = controller.isFirstHalf.value;
                        final values = controller.getHalfYearlyMonthlyData(isFirstHalf: isFirstHalf);
                        final labels = controller.getHalfYearMonthLabels(isFirstHalf: isFirstHalf);
                        return MonthChart(values: values, labels: labels);
                      }),
                    ],
                  );

                default:return const SizedBox.shrink();
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
  final double barValue;
  const DayChart({super.key, required this.barValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        width: 120,
        child: BarChart(
          BarChartData(
            maxY: 50,
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
                showingTooltipIndicators: [0],
              ),
            ],
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(6),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    barValue.toStringAsFixed(0),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
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
              bottomTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
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
          ),
        ),
      ),
    );
  }
}


/// Week Chart
class WeekChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const WeekChart({super.key, required this.values, required this.labels});

  @override
  Widget build(BuildContext context) {
    final double maxY = (values.isNotEmpty) ? (values.reduce((a, b) => a > b ? a : b) + 5) : 10;
    const double barWidth = 20;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: BarChart(
          BarChartData(
            maxY: maxY,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipMargin: 8,
                tooltipPadding: const EdgeInsets.all(6),
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    values[groupIndex].toStringAsFixed(0),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              horizontalInterval: 5,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, _) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
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
                        style: const TextStyle(fontSize: 11),
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
                showingTooltipIndicators: [0],
                barRods: [
                  BarChartRodData(
                    toY: values[index],
                    width: barWidth,
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
      ),
    );
  }
}


/// Month chart
class MonthChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const MonthChart({
    super.key,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    const double maxY = 100;
    const double barWidth = 20;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: BarChart(
          BarChartData(
            maxY: maxY,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    values[groupIndex].toStringAsFixed(0),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 20,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
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
                        style: const TextStyle(fontSize: 11),
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
                showingTooltipIndicators: [0],
                barRods: [
                  BarChartRodData(
                    toY: values[index],
                    width: barWidth,
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
      ),
    );
  }
}








