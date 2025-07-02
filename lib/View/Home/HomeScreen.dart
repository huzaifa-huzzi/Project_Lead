import 'package:flutter/material.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizingConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 180, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Bar
            Container(
              width: 300,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  SizedBox(width: SizingConfig.width(0.02)),
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

            SizedBox(height: SizingConfig.height(0.04)),

            ///  Completed Form Preview
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: const EdgeInsets.all(24),
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
                    /// Section 1
                    sectionTitle("Personal Info"),
                    Row(
                      children: [
                        buildInfoRow("Name", "Huzaifa Khan"),
                        const SizedBox(width: 16),
                        buildInfoRow("Email", "huzaifa@gmail.com"),
                      ],
                    ),
                    Row(
                      children: [
                        buildInfoRow("Phone Number", "+92 300 1234567"),
                        const SizedBox(width: 16),
                        buildInfoRow("Phone Type", "Business"),
                      ],
                    ),

                    /// Section 2
                    sectionTitle("Location Info"),
                    Row(
                      children: [
                        buildInfoRow("Zip Code", "44000"),
                        const SizedBox(width: 16),
                        buildInfoRow("Country", "Pakistan"),
                      ],
                    ),
                    Row(
                      children: [
                        buildInfoRow("Suburb", "Wah Cantt"),
                        const SizedBox(width: 16),
                        buildInfoRow("State", "Punjab"),
                      ],
                    ),

                    /// Section 3
                    sectionTitle("Web & Address Info"),
                    Row(
                      children: [
                        buildInfoRow("Website", "www.huzaifadev.com"),
                        const SizedBox(width: 16),
                        buildInfoRow("Address", "Malakand Stop, Wah"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🏷️ Section Header Widget
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
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

  /// 🧾 Data Display Field Widget
  Widget buildInfoRow(String title, String value) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
