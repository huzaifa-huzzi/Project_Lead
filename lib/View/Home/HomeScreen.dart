import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/HomeController..dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
            /// Text + Search + Profile
            Row(
              children: [
                /// Text
                Icon(Icons.menu_open,size: 23,color: AppColors.primaryColor,),
                SizedBox(width:  SizingConfig.width(0.02),),
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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

                /// Profile Pic
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signout') {
                      // Logic
                    }
                  },
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
                  child:Container(
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

            ///  Dropdown + Graph
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Form Submissions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                ),
                Obx(() => DropdownButton<String>(
                  value: controller.selectedRange.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateChart(value);
                    }
                  },
                  items: ['Day', 'Week', 'Month']
                      .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
                      .toList(),
                )),
              ],
            ),

            SizedBox(height: SizingConfig.height(0.03)),

            ///  Graph
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
                          padding: EdgeInsets.only(
                              right: SizingConfig.width(0.01)),
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(fontSize: SizingConfig.width(0.012)),
                          ),
                        ),
                        interval: (controller.maxY / 5).ceilToDouble(),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: EdgeInsets.only(top: SizingConfig.height(0.005)),
                          child: Text(
                            controller.getBottomTitle(value.toInt()),
                            style:
                            TextStyle(fontSize: SizingConfig.width(0.012)),
                          ),
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


            ///  Completed Form
            const Text("Forms",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: SizingConfig.height(0.03)),

            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: EdgeInsets.all(SizingConfig.width(0.03)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color.fromRGBO(162, 162, 170, 0.16),
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Personal Info"),
                    rowWrap([
                      buildInfoRow("Name", "Huzaifa Khan"),
                      buildInfoRow("Email", "huzaifa@gmail.com"),
                    ]),
                    rowWrap([
                      buildInfoRow("Phone Number", "+92 300 1234567"),
                      buildInfoRow("Phone Type", "Business"),
                    ]),

                    sectionTitle("Location Info"),
                    rowWrap([
                      buildInfoRow("Zip Code", "44000"),
                      buildInfoRow("Country", "Pakistan"),
                    ]),
                    rowWrap([
                      buildInfoRow("Suburb", "Wah Cantt"),
                      buildInfoRow("State", "Punjab"),
                    ]),

                    sectionTitle("Web & Address Info"),
                    rowWrap([
                      buildInfoRow("Website", "www.huzaifadev.com"),
                      buildInfoRow("Address", "Malakand Stop, Wah"),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizingConfig.height(0.015)),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(bottom: SizingConfig.height(0.02)),
        padding: EdgeInsets.symmetric(
          horizontal: SizingConfig.width(0.02),
          vertical: SizingConfig.height(0.015),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: SizingConfig.width(0.012),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            SizedBox(height: SizingConfig.height(0.004)),
            Text(value,
                style: TextStyle(
                    fontSize: SizingConfig.width(0.014),
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget rowWrap(List<Widget> children) {
    return Wrap(
      spacing: SizingConfig.width(0.02),
      runSpacing: SizingConfig.height(0.01),
      children: children,
    );
  }
}
