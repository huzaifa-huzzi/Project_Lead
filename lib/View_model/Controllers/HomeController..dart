import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var total = 128.obs;
  var daily = 24.obs;
  var weekly = 84.obs;
  var monthly = 300.obs;

  var selectedTab = 0.obs;

  /// For day chart
  var selectedDate = DateTime
      .now()
      .obs;

  Map<DateTime, int> formCountsByDate = {
    DateTime(2025, 7, 8): 3,
    DateTime(2025, 7, 9): 5,
  };


  int getFormCountForSelectedDate() {
    String key = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    return (key.hashCode.abs() % 30) + 1;
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  /// For week chart
  var selectedWeekStartDate = DateTime
      .now()
      .subtract(Duration(days: DateTime
      .now()
      .weekday - 1))
      .obs;
  var selectedWeekDates = <DateTime>[].obs;

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }


  @override
  void onInit() {
    super.onInit();
    _updateSelectedWeekDates();
  }

  void _updateSelectedWeekDates() {
    final start = selectedWeekStartDate.value;
    final today = DateTime.now();

    // If it's a past week, include all 7 days
    final isPastWeek = today
        .difference(start)
        .inDays >= 6;

    selectedWeekDates.value = List.generate(7, (index) {
      final date = start.add(Duration(days: index));
      return date;
    }).where((date) => isPastWeek || !date.isAfter(today)).toList();

    selectedWeekDates.refresh();
  }

  void pickWeekDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedWeekStartDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final startOfWeek = picked.subtract(Duration(days: picked.weekday - 1));
      selectedWeekStartDate.value = startOfWeek;
      _updateSelectedWeekDates();
    }
  }

  List<int> getWeekFormCounts() {
    return selectedWeekDates.map((date) {
      // Generate dummy data based on date hash
      return (date.hashCode.abs() % 30) + 1;
    }).toList();
  }

  void debugFormCount() {
    print("🔍 selectedWeekDates: ${selectedWeekDates.map(normalizeDate)
        .toList()}");
    print("📊 dataKeys: ${formCountsByDate.keys}");
  }


  /// Month chart

  var isFirstHalf = true.obs;
  var selectedYear = DateTime
      .now()
      .year
      .obs;

  void toggleHalf(bool firstHalf) {
    isFirstHalf.value = firstHalf;
  }

  void pickYear(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedYear.value),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: "Select Year",
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (picked != null) {
      selectedYear.value = picked.year;
    }
  }

  List<double> getHalfYearlyMonthlyData({required bool isFirstHalf}) {
    final now = DateTime.now();
    final int currentMonth = now.month;
    final int selected = selectedYear.value;

    final List<double> data = [];
    final start = isFirstHalf ? 1 : 7;
    final end = isFirstHalf ? 6 : 12;

    for (int i = start; i <= end; i++) {
      if (selected == now.year && i > currentMonth) {
        data.add(0);
      } else {
        final hash = '$selected-$i'.hashCode;
        data.add((hash.abs() % 50 + 10).toDouble());
      }
    }

    return data;
  }


  List<String> getHalfYearMonthLabels({required bool isFirstHalf}) {
    final start = isFirstHalf ? 1 : 7;
    final end = isFirstHalf ? 6 : 12 ;

    return List.generate(end - start + 1, (index) {
      final month = start + index;
      return DateFormat('MMM').format(DateTime(0, month));
    });
  }


}


