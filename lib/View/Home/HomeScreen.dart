import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/HomeController..dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key,});

  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);


    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizingConfig.width(0.06),
          vertical: SizingConfig.height(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row (menu + profile)
            Row(
              children: [
                Icon(Icons.menu_open, size: 23),
                SizedBox(width: SizingConfig.width(0.02)),
                Text("Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),

                /// Search Bar
                Container(
                  width: SizingConfig.width(0.3),
                  height: SizingConfig.height(0.065),
                  padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.01)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(162, 162, 170, 0.16),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: SizingConfig.width(0.01)),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search here',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// Profile Image + Email
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'signout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 18, color: Colors.black54),
                          SizedBox(width: SizingConfig.width(0.01)),
                          Text('Sign Out'),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/Pic.png'),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.07)),

            /// Graph
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Form Submissions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
                Obx(() => DropdownButton<String>(
                  value: controller.selectedRange.value,
                  onChanged: (value) {
                    if (value != null) controller.updateChart(value);
                  },
                  items: ['Day', 'Week', 'Month']
                      .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                )),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.03)),

            Obx(() => AspectRatio(
              aspectRatio: 1.8,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: controller.maxY.value,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: SizingConfig.width(0.05),
                        getTitlesWidget: (value, meta) => Padding(
                          padding: EdgeInsets.only(right: SizingConfig.width(0.01)),
                          child: Text(value.toInt().toString(),
                              style: TextStyle(fontSize: SizingConfig.width(0.012))),
                        ),
                        interval: (controller.maxY / 5).ceilToDouble(),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: EdgeInsets.only(top: SizingConfig.height(0.005)),
                          child: Text(controller.getBottomTitle(value.toInt()),
                              style: TextStyle(fontSize: SizingConfig.width(0.012))),
                        ),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: controller.getBarData(),
                ),
              ),
            )),

            SizedBox(height: SizingConfig.height(0.06)),

            /// Filled Form
            Text(
              "Forms Submitted",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            SizedBox(height: SizingConfig.height(0.03)),

            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _readonlyField("Name", "Huzaifa Khan"),
                    _readonlyField("Email", "huzaifaatta8152@gmail.com"),
                    _readonlyField("Phone", "+92 331 5178220"),
                    _readonlyField("Phone Type", "Personal"),
                    _readonlyField("Website", "https://huzaifadev.com"),
                    _readonlyField("Address", "Malakand stop near Wah General Hospital"),
                    _readonlyField("Suburb", "Wah Cantt"),
                    _readonlyField("State", "Punjab"),
                    _readonlyField("Country", "Pakistan"),
                    _readonlyField("Zip Code", "4400"),
                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget _readonlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        style: TextStyle(color: Colors.black87),
      ),
    );
  }






}
